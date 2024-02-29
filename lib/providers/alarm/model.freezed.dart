// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AlarmConfig _$AlarmConfigFromJson(Map<String, dynamic> json) {
  return _AlarmConfig.fromJson(json);
}

/// @nodoc
mixin _$AlarmConfig {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// The time of day that the alarm should go off.
  /// Format: "HH:mm"
  String get time => throw _privateConstructorUsedError;

  /// The days of the week that the alarm should repeat on.
  /// 0 is Sunday, 1 is Monday, etc.
  List<int> get days => throw _privateConstructorUsedError;
  AlarmRecurrence get recurrence => throw _privateConstructorUsedError;
  DateTime? get lastTriggered => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlarmConfigCopyWith<AlarmConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmConfigCopyWith<$Res> {
  factory $AlarmConfigCopyWith(
          AlarmConfig value, $Res Function(AlarmConfig) then) =
      _$AlarmConfigCopyWithImpl<$Res, AlarmConfig>;
  @useResult
  $Res call(
      {int id,
      String name,
      String time,
      List<int> days,
      AlarmRecurrence recurrence,
      DateTime? lastTriggered,
      bool enabled});
}

/// @nodoc
class _$AlarmConfigCopyWithImpl<$Res, $Val extends AlarmConfig>
    implements $AlarmConfigCopyWith<$Res> {
  _$AlarmConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? time = null,
    Object? days = null,
    Object? recurrence = null,
    Object? lastTriggered = freezed,
    Object? enabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<int>,
      recurrence: null == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as AlarmRecurrence,
      lastTriggered: freezed == lastTriggered
          ? _value.lastTriggered
          : lastTriggered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmConfigImplCopyWith<$Res>
    implements $AlarmConfigCopyWith<$Res> {
  factory _$$AlarmConfigImplCopyWith(
          _$AlarmConfigImpl value, $Res Function(_$AlarmConfigImpl) then) =
      __$$AlarmConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String time,
      List<int> days,
      AlarmRecurrence recurrence,
      DateTime? lastTriggered,
      bool enabled});
}

/// @nodoc
class __$$AlarmConfigImplCopyWithImpl<$Res>
    extends _$AlarmConfigCopyWithImpl<$Res, _$AlarmConfigImpl>
    implements _$$AlarmConfigImplCopyWith<$Res> {
  __$$AlarmConfigImplCopyWithImpl(
      _$AlarmConfigImpl _value, $Res Function(_$AlarmConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? time = null,
    Object? days = null,
    Object? recurrence = null,
    Object? lastTriggered = freezed,
    Object? enabled = null,
  }) {
    return _then(_$AlarmConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      days: null == days
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<int>,
      recurrence: null == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as AlarmRecurrence,
      lastTriggered: freezed == lastTriggered
          ? _value.lastTriggered
          : lastTriggered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlarmConfigImpl implements _AlarmConfig {
  const _$AlarmConfigImpl(
      {required this.id,
      required this.name,
      required this.time,
      required final List<int> days,
      required this.recurrence,
      required this.lastTriggered,
      required this.enabled})
      : _days = days;

  factory _$AlarmConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmConfigImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  /// The time of day that the alarm should go off.
  /// Format: "HH:mm"
  @override
  final String time;

  /// The days of the week that the alarm should repeat on.
  /// 0 is Sunday, 1 is Monday, etc.
  final List<int> _days;

  /// The days of the week that the alarm should repeat on.
  /// 0 is Sunday, 1 is Monday, etc.
  @override
  List<int> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  final AlarmRecurrence recurrence;
  @override
  final DateTime? lastTriggered;
  @override
  final bool enabled;

  @override
  String toString() {
    return 'AlarmConfig(id: $id, name: $name, time: $time, days: $days, recurrence: $recurrence, lastTriggered: $lastTriggered, enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.time, time) || other.time == time) &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            (identical(other.recurrence, recurrence) ||
                other.recurrence == recurrence) &&
            (identical(other.lastTriggered, lastTriggered) ||
                other.lastTriggered == lastTriggered) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      time,
      const DeepCollectionEquality().hash(_days),
      recurrence,
      lastTriggered,
      enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmConfigImplCopyWith<_$AlarmConfigImpl> get copyWith =>
      __$$AlarmConfigImplCopyWithImpl<_$AlarmConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmConfigImplToJson(
      this,
    );
  }
}

abstract class _AlarmConfig implements AlarmConfig {
  const factory _AlarmConfig(
      {required final int id,
      required final String name,
      required final String time,
      required final List<int> days,
      required final AlarmRecurrence recurrence,
      required final DateTime? lastTriggered,
      required final bool enabled}) = _$AlarmConfigImpl;

  factory _AlarmConfig.fromJson(Map<String, dynamic> json) =
      _$AlarmConfigImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override

  /// The time of day that the alarm should go off.
  /// Format: "HH:mm"
  String get time;
  @override

  /// The days of the week that the alarm should repeat on.
  /// 0 is Sunday, 1 is Monday, etc.
  List<int> get days;
  @override
  AlarmRecurrence get recurrence;
  @override
  DateTime? get lastTriggered;
  @override
  bool get enabled;
  @override
  @JsonKey(ignore: true)
  _$$AlarmConfigImplCopyWith<_$AlarmConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AlarmState _$AlarmStateFromJson(Map<String, dynamic> json) {
  return _AlarmState.fromJson(json);
}

/// @nodoc
mixin _$AlarmState {
  List<AlarmConfig> get alarms => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlarmStateCopyWith<AlarmState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmStateCopyWith<$Res> {
  factory $AlarmStateCopyWith(
          AlarmState value, $Res Function(AlarmState) then) =
      _$AlarmStateCopyWithImpl<$Res, AlarmState>;
  @useResult
  $Res call({List<AlarmConfig> alarms});
}

/// @nodoc
class _$AlarmStateCopyWithImpl<$Res, $Val extends AlarmState>
    implements $AlarmStateCopyWith<$Res> {
  _$AlarmStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alarms = null,
  }) {
    return _then(_value.copyWith(
      alarms: null == alarms
          ? _value.alarms
          : alarms // ignore: cast_nullable_to_non_nullable
              as List<AlarmConfig>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmStateImplCopyWith<$Res>
    implements $AlarmStateCopyWith<$Res> {
  factory _$$AlarmStateImplCopyWith(
          _$AlarmStateImpl value, $Res Function(_$AlarmStateImpl) then) =
      __$$AlarmStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AlarmConfig> alarms});
}

/// @nodoc
class __$$AlarmStateImplCopyWithImpl<$Res>
    extends _$AlarmStateCopyWithImpl<$Res, _$AlarmStateImpl>
    implements _$$AlarmStateImplCopyWith<$Res> {
  __$$AlarmStateImplCopyWithImpl(
      _$AlarmStateImpl _value, $Res Function(_$AlarmStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alarms = null,
  }) {
    return _then(_$AlarmStateImpl(
      alarms: null == alarms
          ? _value._alarms
          : alarms // ignore: cast_nullable_to_non_nullable
              as List<AlarmConfig>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlarmStateImpl implements _AlarmState {
  const _$AlarmStateImpl({final List<AlarmConfig> alarms = const []})
      : _alarms = alarms;

  factory _$AlarmStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmStateImplFromJson(json);

  final List<AlarmConfig> _alarms;
  @override
  @JsonKey()
  List<AlarmConfig> get alarms {
    if (_alarms is EqualUnmodifiableListView) return _alarms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alarms);
  }

  @override
  String toString() {
    return 'AlarmState(alarms: $alarms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmStateImpl &&
            const DeepCollectionEquality().equals(other._alarms, _alarms));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_alarms));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmStateImplCopyWith<_$AlarmStateImpl> get copyWith =>
      __$$AlarmStateImplCopyWithImpl<_$AlarmStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmStateImplToJson(
      this,
    );
  }
}

abstract class _AlarmState implements AlarmState {
  const factory _AlarmState({final List<AlarmConfig> alarms}) =
      _$AlarmStateImpl;

  factory _AlarmState.fromJson(Map<String, dynamic> json) =
      _$AlarmStateImpl.fromJson;

  @override
  List<AlarmConfig> get alarms;
  @override
  @JsonKey(ignore: true)
  _$$AlarmStateImplCopyWith<_$AlarmStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
