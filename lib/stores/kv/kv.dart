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

  static bool get ringing => preferences.getBool('ringing') ?? false;
  static Future<void> setRinging(bool value) async {
    await preferences.setBool('ringing', value);
  }
}
