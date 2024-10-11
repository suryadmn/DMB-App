import 'package:shared_preferences/shared_preferences.dart';

/// A helper class to manage shared preferences for storing and retrieving
/// persistent data such as tokens.
class SharedPreferencesHelper {
  /// Key used to store the token in shared preferences.
  static const String prefsTokenKey = 'sharedpref_token_key';
  static const String prefsSessionIdKey = 'sharedpref_session_id_key';
  static const String prefsHasLoginKey = 'sharedpref_has_login_key';
  static const String prefsAccountIdKey = 'sharedpref_account_id_key';

  /// Saves a new token to shared preferences.
  ///
  /// The [token] parameter is required and will be stored under the key
  /// [prefsTokenKey].
  ///
  /// Example:
  /// ```dart
  /// await SharedPreferencesHelper.setNewToken(token: 'your_token_here');
  /// ```
  static Future<void> setNewToken({required String token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(prefsTokenKey, token);
  }

  static Future<void> setNewSSessionId({required String sessionId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(prefsSessionIdKey, sessionId);
  }

  static Future<void> setHasLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefsHasLoginKey, true);
  }

  static Future<void> setAccountId({required int accountId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(prefsAccountIdKey, accountId);
  }

  /// Retrieves a token from shared preferences using the provided [key].
  ///
  /// If no value is found for the given [key], an empty string is returned.
  ///
  /// Example:
  /// ```dart
  /// String token = await SharedPreferencesHelper.getToken(key: SharedPreferencesHelper.prefsTokenKey);
  /// ```
  static Future<String> getToken({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<String> getSessionId({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<bool> getHasLogin({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<int> getAccountId({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future<void> deletePrefs({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
