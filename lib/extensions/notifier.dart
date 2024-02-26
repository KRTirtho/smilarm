import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin StatePersistance<T> on StateNotifier<T> {
  String get key;

  @protected
  FutureOr<T> fromJson(Map<String, dynamic> json);
  @protected
  Map<String, dynamic> toJson(T state);

  @protected
  void load() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(key);

    if (json != null) {
      state = await fromJson(jsonDecode(json));
    }
  }

  void _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(toJson(state)));
  }

  @override
  set state(value) {
    super.state = value;
    _persist();
  }
}
