import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smilarm/modules/home/alarm_card.dart';
import 'package:smilarm/modules/home/create_alarm.dart';
import 'package:smilarm/providers/alarm/alarm.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final mediaQuery = MediaQuery.of(context);
    final alarms = ref.watch(alarmProvider);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Smilarm'),
        trailing: CupertinoButton(
          child: const Icon(CupertinoIcons.add),
          onPressed: () async {
            final result = await showCupertinoModalPopup<String>(
              context: context,
              builder: (context) => SizedBox(
                width: double.infinity,
                height: mediaQuery.size.height,
                child: const CreateAlarmDialog(),
              ),
            );

            if (result == null || !context.mounted) {
              return;
            }

            showToast(result, context: context);
          },
        ),
      ),
      child: SafeArea(
          child: ListView.builder(
        padding: const EdgeInsets.only(top: 16),
        itemCount: alarms.alarms.length,
        itemBuilder: (context, index) {
          return AlarmCard(alarm: alarms.alarms[index]);
        },
      )),
    );
  }
}
