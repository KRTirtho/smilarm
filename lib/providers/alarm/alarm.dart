import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smilarm/extensions/notifier.dart';
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

  void add(AlarmConfig alarm) {
    state = state.copyWith(alarms: [...state.alarms, alarm]);
  }

  void remove(AlarmConfig alarm) {
    state = state.copyWith(
      alarms: state.alarms.where((a) => a != alarm).toList(),
    );
  }

  void update(AlarmConfig updatedAlarm) {
    state = state.copyWith(
      alarms: [
        for (final alarm in state.alarms)
          if (updatedAlarm.id == alarm.id) updatedAlarm else alarm,
      ],
    );
  }
}

final alarmProvider = StateNotifierProvider<AlarmNotifier, AlarmState>(
  (ref) => AlarmNotifier(),
);
