import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Prefs key
  static const String prefsTokenKey = 'sharedpref_token_key';

  static Future<void> setNewToken({required String token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(prefsTokenKey, token);
  }

  static Future<String> getToken({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }
}
