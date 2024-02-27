import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'model.freezed.dart';
part 'model.g.dart';

enum AlarmRecurrence {
  repeat,
  once,
}

const uuid = Uuid();

@freezed
class AlarmConfig with _$AlarmConfig {
  const factory AlarmConfig.def({
    required String id,
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

  factory AlarmConfig({
    required String name,
    required String time,
    required List<int> days,
    required AlarmRecurrence recurrence,
    DateTime? lastTriggered,
    required bool enabled,
  }) {
    return _AlarmConfig(
      id: uuid.v4(),
      name: name,
      time: time,
      days: days,
      recurrence: recurrence,
      lastTriggered: lastTriggered,
      enabled: enabled,
    );
  }

  factory AlarmConfig.fromJson(Map<String, dynamic> json) =>
      _$AlarmConfigFromJson(json);
}

@freezed
class AlarmState with _$AlarmState {
  const factory AlarmState({
    @Default([]) List<AlarmConfig> alarms,
  }) = _AlarmState;

  factory AlarmState.fromJson(Map<String, dynamic> json) =>
      _$AlarmStateFromJson(json);
}
