import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

enum AlarmRecurrence {
  repeat,
  once,
}

@freezed
class AlarmConfig with _$AlarmConfig {
  const factory AlarmConfig({
    required int id,
    required String name,

    /// The time of day that the alarm should go off.
    /// Format: "HH:mm"
    required String time,

    /// The days of the week that the alarm should repeat on.
    /// 0 is Sunday, 1 is Monday, etc.
    required List<int> days,
    required AlarmRecurrence recurrence,
    required DateTime? lastTriggered,
    required bool enabled,
  }) = _AlarmConfig;

  factory AlarmConfig.fromJson(Map<String, dynamic> json) =>
      _$AlarmConfigFromJson(json);
}

extension TimeOfDayFromTime on AlarmConfig {
  TimeOfDay get timeOfDay {
    final [hh, mm] = time.split(':');
    return TimeOfDay(
      hour: int.parse(hh),
      minute: int.parse(mm),
    );
  }
}

@freezed
class AlarmState with _$AlarmState {
  const factory AlarmState({
    @Default([]) List<AlarmConfig> alarms,
  }) = _AlarmState;

  factory AlarmState.fromJson(Map<String, dynamic> json) =>
      _$AlarmStateFromJson(json);
}
