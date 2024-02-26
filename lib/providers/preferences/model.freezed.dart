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

PreferencesState _$PreferencesStateFromJson(Map<String, dynamic> json) {
  return _PreferencesState.fromJson(json);
}

/// @nodoc
mixin _$PreferencesState {
  ThemeMode get themeMode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferencesStateCopyWith<PreferencesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferencesStateCopyWith<$Res> {
  factory $PreferencesStateCopyWith(
          PreferencesState value, $Res Function(PreferencesState) then) =
      _$PreferencesStateCopyWithImpl<$Res, PreferencesState>;
  @useResult
  $Res call({ThemeMode themeMode});
}

/// @nodoc
class _$PreferencesStateCopyWithImpl<$Res, $Val extends PreferencesState>
    implements $PreferencesStateCopyWith<$Res> {
  _$PreferencesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreferencesStateImplCopyWith<$Res>
    implements $PreferencesStateCopyWith<$Res> {
  factory _$$PreferencesStateImplCopyWith(_$PreferencesStateImpl value,
          $Res Function(_$PreferencesStateImpl) then) =
      __$$PreferencesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ThemeMode themeMode});
}

/// @nodoc
class __$$PreferencesStateImplCopyWithImpl<$Res>
    extends _$PreferencesStateCopyWithImpl<$Res, _$PreferencesStateImpl>
    implements _$$PreferencesStateImplCopyWith<$Res> {
  __$$PreferencesStateImplCopyWithImpl(_$PreferencesStateImpl _value,
      $Res Function(_$PreferencesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
  }) {
    return _then(_$PreferencesStateImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferencesStateImpl implements _PreferencesState {
  const _$PreferencesStateImpl({this.themeMode = ThemeMode.system});

  factory _$PreferencesStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreferencesStateImplFromJson(json);

  @override
  @JsonKey()
  final ThemeMode themeMode;

  @override
  String toString() {
    return 'PreferencesState(themeMode: $themeMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferencesStateImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, themeMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferencesStateImplCopyWith<_$PreferencesStateImpl> get copyWith =>
      __$$PreferencesStateImplCopyWithImpl<_$PreferencesStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferencesStateImplToJson(
      this,
    );
  }
}

abstract class _PreferencesState implements PreferencesState {
  const factory _PreferencesState({final ThemeMode themeMode}) =
      _$PreferencesStateImpl;

  factory _PreferencesState.fromJson(Map<String, dynamic> json) =
      _$PreferencesStateImpl.fromJson;

  @override
  ThemeMode get themeMode;
  @override
  @JsonKey(ignore: true)
  _$$PreferencesStateImplCopyWith<_$PreferencesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
