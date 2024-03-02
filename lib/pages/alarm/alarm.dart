import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smilarm/main.dart';
import 'package:smilarm/modules/home/alarm_card.dart';
import 'package:smilarm/modules/home/create_alarm.dart';
import 'package:smilarm/providers/alarm/alarm.dart';
import 'package:smilarm/stores/kv/kv.dart';

class AlarmPage extends ConsumerWidget {
  const AlarmPage({super.key});

  Future<void> stop(BuildContext context) async {
    final alarmCbSendPort = IsolateNameServer.lookupPortByName(
      alarmIsolatePortName,
    );
    alarmCbSendPort?.send("stop");
    context.go("/");
    await KVStore.setAlarmId(null);
  }

  @override
  Widget build(BuildContext context, ref) {
    final alarms = ref.watch(alarmProvider);

    final alarm = alarms.alarms.firstWhereOrNull(
      (alarm) => alarm.id == KVStore.alarmId,
    );

    return SafeArea(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(60),
                Center(
                  child: Text(
                    timeJmFormatter.format(
                      timeHmFormatter.parse(alarm?.time ?? "00:00"),
                    ),
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ),
                const Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alarm?.name != null
                          ? "It's time for ${alarm?.name}"
                          : 'Wake up!',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(5),
                    if (alarm?.message?.isNotEmpty == true)
                      Text(
                        alarm!.message!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                Center(
                  child: CupertinoButton.filled(
                    onPressed: () async {
                      final shouldStop =
                          await context.push<bool>("/alarm/camera");
                      if (shouldStop == true && context.mounted) {
                        await stop(context);
                      }
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.smiley,
                          color: CupertinoColors.white,
                        ),
                        Gap(10),
                        Text(
                          "Stop with a smile",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
