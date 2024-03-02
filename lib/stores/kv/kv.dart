import 'package:shared_preferences/shared_preferences.dart';

class KVStore {
  static SharedPreferences? _preferences;
  static SharedPreferences get preferences {
    if (_preferences == null) {
      throw Exception('KVStore not initialized');
    }
    return _preferences!;
  }

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static int? get alarmId => preferences.getInt('alarmId');
  static Future<void> setAlarmId(int? value) async {
    if (value == null) {
      await preferences.remove('alarmId');
      return;
    }
    await preferences.setInt('alarmId', value);
  }
}
