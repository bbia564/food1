import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPreferencesUtil {
  static late Future<SharedPreferences> _prefs;

  static Future<SharedPreferences> getPrefs() async {
    _prefs = SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<String> getString(String key, {String defaultValue = ''}) async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getString(key) ?? defaultValue;
  }

  static Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.setString(key, value);
  }

  static Future<int> getInt(String key, {int defaultValue = 0}) async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getInt(key) ?? defaultValue;
  }

  static Future<bool> setInt(String key, int value) async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.setInt(key, value);
  }

  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getBool(key) ?? defaultValue;
  }

  static Future<bool> setBool(String key, bool value) async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.setBool(key, value);
  }

  static Future<double> getDouble(String key, {double defaultValue = 0.0}) async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getDouble(key) ?? defaultValue;
  }

  static Future<bool> setDouble(String key, double value) async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.setDouble(key, value);
  }

  static Future<bool> remove(String key) async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.remove(key);
  }

  static Future<Future<bool>> clear() async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.clear();
  }
}
