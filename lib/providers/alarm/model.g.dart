// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlarmConfigImpl _$$AlarmConfigImplFromJson(Map<String, dynamic> json) =>
    _$AlarmConfigImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      message: json['message'] as String?,
      time: json['time'] as String,
      days: (json['days'] as List<dynamic>).map((e) => e as int).toList(),
      recurrence: $enumDecode(_$AlarmRecurrenceEnumMap, json['recurrence']),
      lastTriggered: json['lastTriggered'] == null
          ? null
          : DateTime.parse(json['lastTriggered'] as String),
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$$AlarmConfigImplToJson(_$AlarmConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'message': instance.message,
      'time': instance.time,
      'days': instance.days,
      'recurrence': _$AlarmRecurrenceEnumMap[instance.recurrence]!,
      'lastTriggered': instance.lastTriggered?.toIso8601String(),
      'enabled': instance.enabled,
    };

const _$AlarmRecurrenceEnumMap = {
  AlarmRecurrence.repeat: 'repeat',
  AlarmRecurrence.once: 'once',
};

_$AlarmStateImpl _$$AlarmStateImplFromJson(Map<String, dynamic> json) =>
    _$AlarmStateImpl(
      alarms: (json['alarms'] as List<dynamic>?)
              ?.map((e) => AlarmConfig.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AlarmStateImplToJson(_$AlarmStateImpl instance) =>
    <String, dynamic>{
      'alarms': instance.alarms,
    };
