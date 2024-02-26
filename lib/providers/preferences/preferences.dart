import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smilarm/extensions/notifier.dart';
import 'package:smilarm/providers/preferences/model.dart';

class PreferencesNotifier extends StateNotifier<PreferencesState>
    with StatePersistance {
  PreferencesNotifier() : super(const PreferencesState()) {
    load();
  }

  @override
  String get key => 'preferences';
  @override
  FutureOr<PreferencesState> fromJson(Map<String, dynamic> json) =>
      PreferencesState.fromJson(json);
  @override
  Map<String, dynamic> toJson(PreferencesState state) => state.toJson();

  void setTheme(ThemeMode isDark) {
    state = state.copyWith(themeMode: isDark);
  }
}

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, PreferencesState>((ref) {
  return PreferencesNotifier();
});
