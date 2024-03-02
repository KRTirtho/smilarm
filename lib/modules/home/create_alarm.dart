import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smilarm/extensions/duration.dart';
import 'package:smilarm/providers/alarm/alarm.dart';
import 'package:smilarm/providers/alarm/model.dart';
import 'package:smilarm/utils/uid.dart';

final timeHmFormatter = DateFormat.Hm();

class CreateAlarmDialog extends HookConsumerWidget {
  final AlarmConfig? alarm;
  const CreateAlarmDialog({
    super.key,
    this.alarm,
  });

  @override
  Widget build(BuildContext context, ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);
    final alarmNotifier = ref.read(alarmProvider.notifier);

    final nameController = useTextEditingController(text: alarm?.name);
    final messageController = useTextEditingController(text: alarm?.name);
    final enabled = useState(alarm?.enabled ?? true);
    final time = useState(alarm?.timeOfDay ?? TimeOfDay.now());
    final today = DateTime.now().weekday - 1;
    final days = useState<List<bool>>(
      alarm != null
          ? List.generate(7, (index) => alarm!.days.contains(index + 1))
          : List.generate(7, (index) => index == today),
    );
    final recurrence =
        useState<AlarmRecurrence>(alarm?.recurrence ?? AlarmRecurrence.once);

    return CupertinoPopupSurface(
      child: CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Home',
          middle: const Text('Create Alarm'),
          trailing: CupertinoSwitch(
            value: enabled.value,
            onChanged: (value) {
              enabled.value = value;
            },
          ),
        ),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CupertinoButton(
                    child: Text(
                      time.value.format(context),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 48,
                        color:
                            CupertinoColors.activeOrange.resolveFrom(context),
                      ),
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemBackground
                                .resolveFrom(context),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(16),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            minimumDate: days.value[today] &&
                                    days.value.none((e) => e == true)
                                ? DateTime.now().add(const Duration(minutes: 1))
                                : null,
                            onDateTimeChanged: (value) {
                              time.value = TimeOfDay.fromDateTime(value);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.systemGrey.resolveFrom(context),
                      width: .5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color:
                        CupertinoColors.systemBackground.resolveFrom(context),
                  ),
                  child: CupertinoTextFormFieldRow(
                    controller: nameController,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    prefix: const Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    placeholder: "Required",
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(8),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.calendar),
                  title: const Text('Recurrence'),
                  padding: EdgeInsets.zero,
                  leadingToTitle: 4,
                  trailing: CupertinoSegmentedControl(
                    children: {
                      AlarmRecurrence.once.index: const Text('Once'),
                      AlarmRecurrence.repeat.index: const Text('  Repeat  '),
                    },
                    groupValue: recurrence.value.index,
                    onValueChanged: (value) {
                      recurrence.value = AlarmRecurrence.values[value];
                      if (value == AlarmRecurrence.once.index) {
                        days.value =
                            List.generate(7, (index) => index == today);
                      }
                    },
                  ),
                ),
                const Gap(8),
                Center(
                  child: ToggleButtons(
                    fillColor: CupertinoColors.activeOrange
                        .resolveFrom(context)
                        .withOpacity(.1),
                    borderRadius: BorderRadius.circular(8),
                    borderColor:
                        CupertinoColors.systemGrey.resolveFrom(context),
                    selectedBorderColor: CupertinoColors.activeOrange,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    selectedColor: CupertinoColors.activeOrange,
                    color: CupertinoColors.label.resolveFrom(context),
                    isSelected: days.value,
                    onPressed: (index) {
                      if (recurrence.value == AlarmRecurrence.once) {
                        days.value = List.generate(7, (i) => i == index);
                      } else if (!(days.value[index] &&
                          days.value.where((e) => e).length == 1)) {
                        days.value = days.value
                            .mapIndexed(
                              (i, value) => i == index ? !value : value,
                            )
                            .toList();
                      }
                    },
                    children: const [
                      Text('M'),
                      Text('T'),
                      Text('W'),
                      Text('T'),
                      Text('F'),
                      Text('S'),
                      Text('S'),
                    ],
                  ),
                ),
                const Gap(20),
                CupertinoTextField(
                  controller: messageController,
                  placeholder: "Message (Optional)",
                  minLines: 4,
                  maxLines: 4,
                  maxLength: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.systemGrey.resolveFrom(context),
                      width: .5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color:
                        CupertinoColors.systemBackground.resolveFrom(context),
                  ),
                ),
                const Gap(48),
                CupertinoButton.filled(
                  child: const Text('Save'),
                  onPressed: () async {
                    final currentTime = DateTime.now();
                    final currentTimeWithTimeOfDay = currentTime.copyWith(
                      hour: time.value.hour,
                      minute: time.value.minute,
                    );
                    final isOnceAndPastTime = recurrence.value ==
                            AlarmRecurrence.once &&
                        (currentTime.weekday - 1) == days.value.indexOf(true) &&
                        currentTime.isAfter(currentTimeWithTimeOfDay);

                    if (formKey.currentState?.validate() != true ||
                        isOnceAndPastTime) return;
                    if (alarm == null) {
                      await alarmNotifier.add(
                        AlarmConfig(
                          id: uid(),
                          name: nameController.text,
                          message: messageController.text,
                          enabled: enabled.value,
                          time:
                              timeHmFormatter.format(currentTimeWithTimeOfDay),
                          days: days.value
                              .mapIndexed((i, value) => value ? i + 1 : null)
                              .whereNotNull()
                              .toList(),
                          recurrence: recurrence.value,
                          lastTriggered: null,
                        ),
                      );
                    } else {
                      await alarmNotifier.update(
                        alarm!.copyWith(
                          name: nameController.text,
                          message: messageController.text,
                          enabled: enabled.value,
                          time:
                              timeHmFormatter.format(currentTimeWithTimeOfDay),
                          days: days.value
                              .mapIndexed((i, value) => value ? i + 1 : null)
                              .whereNotNull()
                              .toList(),
                          recurrence: recurrence.value,
                        ),
                      );
                    }
                    final firstFireTime = currentTimeWithTimeOfDay.add(
                      Duration(
                        days: (days.value.indexOf(true) - currentTime.weekday) %
                            7,
                      ),
                    );
                    final leftTimeToFire =
                        firstFireTime.difference(DateTime.now());
                    if (context.mounted) {
                      context.pop(
                        '${nameController.text} will go off in ${leftTimeToFire.formatHHmm()}',
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
