import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smilarm/extensions/string.dart';
import 'package:smilarm/modules/home/create_alarm.dart';
import 'package:smilarm/providers/alarm/alarm.dart';
import 'package:smilarm/providers/alarm/model.dart';

const daysToString = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];

final timeJmFormatter = DateFormat.jm();

class AlarmCard extends HookConsumerWidget {
  final AlarmConfig alarm;
  const AlarmCard({super.key, required this.alarm});

  @override
  Widget build(BuildContext context, ref) {
    final theme = CupertinoTheme.of(context);
    final alarmNotifier = ref.read(alarmProvider.notifier);

    final days = alarm.days.map((day) => daysToString[day - 1]).join('  ');
    final [hours, minutes] = alarm.time.split(':');
    final dateTime = DateTime.now().copyWith(
      hour: int.parse(hours),
      minute: int.parse(minutes),
    );

    return Card(
      color: CupertinoColors.secondarySystemFill.resolveFrom(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: CupertinoColors.secondarySystemBackground
                  .resolveFrom(context),
              borderRadius: BorderRadius.circular(8).copyWith(
                bottomLeft: const Radius.circular(0),
                bottomRight: const Radius.circular(0),
              ),
              border: Border(
                bottom: BorderSide(
                  color: CupertinoColors.systemGrey4.resolveFrom(context),
                ),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  alarm.name,
                  style: theme.textTheme.actionTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(8),
                Chip(
                  padding: EdgeInsets.zero,
                  color: MaterialStatePropertyAll(
                    theme.primaryColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  side: BorderSide.none,
                  label: Text(
                    alarm.recurrence.name.capitalize(),
                    style: theme.textTheme.textStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),
                CupertinoSwitch(
                  value: alarm.enabled,
                  onChanged: (value) {
                    alarmNotifier.update(alarm.copyWith(enabled: value));
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  timeJmFormatter.format(dateTime),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: CupertinoColors.activeOrange,
                    height: 1,
                  ),
                ),
                Text(
                  days,
                  style: theme.textTheme.textStyle.copyWith(
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => const CreateAlarmDialog(),
                  );
                },
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.pencil,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  alarmNotifier.remove(alarm);
                },
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.trash,
                  color: CupertinoColors.systemRed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
