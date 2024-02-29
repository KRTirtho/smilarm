import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smilarm/extensions/notifier.dart';
import 'package:smilarm/main.dart';
import 'package:smilarm/providers/alarm/model.dart';

class AlarmNotifier extends StateNotifier<AlarmState>
    with StatePersistance<AlarmState> {
  AlarmNotifier() : super(const AlarmState()) {
    load();
  }

  @override
  FutureOr<AlarmState> fromJson(Map<String, dynamic> json) =>
      AlarmState.fromJson(json);

  @override
  String get key => 'alarms';

  @override
  Map<String, dynamic> toJson(AlarmState state) => state.toJson();

  Future<void> add(AlarmConfig alarm) async {
    if (alarm.enabled) {
      for (final weekDay in alarm.days) {
        final TimeOfDay(:hour, :minute) = alarm.timeOfDay;
        final time = DateTime.now().copyWith(
          hour: hour,
          minute: minute,
        );
        final startAt = time.weekday == weekDay
            ? time
            : time.add(
                Duration(
                  days: (weekDay - time.weekday) % 7,
                ),
              );
        print("Alarm will fire at $startAt");
        const weekDuration = Duration(days: 7);

        final isSuccessful = switch (alarm.recurrence) {
          AlarmRecurrence.repeat => await AndroidAlarmManager.periodic(
              weekDuration,
              alarm.id + weekDay,
              fireAlarm,
              startAt: startAt,
              wakeup: true,
              rescheduleOnReboot: true,
              allowWhileIdle: true,
              params: alarm.toJson(),
            ),
          AlarmRecurrence.once => await AndroidAlarmManager.oneShotAt(
              startAt,
              alarm.id + weekDay,
              fireAlarm,
              alarmClock: true,
              wakeup: true,
              rescheduleOnReboot: true,
              params: alarm.toJson(),
            )
        };
        if (!isSuccessful) {
          // deleting the halfway set alarms
          for (final weekDay in alarm.days) {
            debugPrint('[Recovery] Deleting alarm ${alarm.id + weekDay}');
            await AndroidAlarmManager.cancel(alarm.id + weekDay);
          }
          throw Exception('Failed to schedule alarm');
        }
        print("Setting alarm ${alarm.name} successful");
      }
    }
    state = state.copyWith(alarms: [...state.alarms, alarm]);
  }

  Future<void> remove(AlarmConfig alarm) async {
    state = state.copyWith(
      alarms: state.alarms.where((a) => a.id != alarm.id).toList(),
    );
    if (!alarm.enabled) return;

    for (final weekDay in alarm.days) {
      await AndroidAlarmManager.cancel(alarm.id + weekDay);
    }
  }

  Future<void> update(AlarmConfig updatedAlarm) async {
    await remove(updatedAlarm);
    await Future.delayed(const Duration(milliseconds: 200));
    await add(updatedAlarm);
  }
}

final alarmProvider = StateNotifierProvider<AlarmNotifier, AlarmState>(
  (ref) => AlarmNotifier(),
);
