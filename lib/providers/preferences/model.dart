import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class PreferencesState with _$PreferencesState {
  const factory PreferencesState({
    @Default(ThemeMode.system) ThemeMode themeMode,
  }) = _PreferencesState;

  factory PreferencesState.fromJson(Map<String, dynamic> json) =>
      _$PreferencesStateFromJson(json);
}
