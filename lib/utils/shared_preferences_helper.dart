import 'package:shared_preferences/shared_preferences.dart';

/// A helper class to manage shared preferences for storing and retrieving
/// persistent data such as tokens.
class SharedPreferencesHelper {
  /// Key used to store the token in shared preferences.
  static const String prefsTokenKey =
      'sharedpref_token_key'; // Key for storing token
  static const String prefsSessionIdKey =
      'sharedpref_session_id_key'; // Key for storing session ID
  static const String prefsHasLoginKey =
      'sharedpref_has_login_key'; // Key to check if user has logged in
  static const String prefsAccountIdKey =
      'sharedpref_account_id_key'; // Key for storing account ID

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
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get shared preferences instance
    prefs.setString(prefsTokenKey, token); // Save the token
  }

  /// Saves a new session ID to shared preferences.
  static Future<void> setNewSSessionId({required String sessionId}) async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get shared preferences instance
    prefs.setString(prefsSessionIdKey, sessionId); // Save the session ID
  }

  /// Sets the login status to true in shared preferences.
  static Future<void> setHasLogin() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get shared preferences instance
    prefs.setBool(prefsHasLoginKey, true); // Set login status to true
  }

  /// Saves the account ID to shared preferences.
  static Future<void> setAccountId({required int accountId}) async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get shared preferences instance
    prefs.setInt(prefsAccountIdKey, accountId); // Save the account ID
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
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get shared preferences instance
    return prefs.getString(key) ?? ""; // Return token or empty string
  }

  /// Retrieves the session ID from shared preferences using the provided [key].
  static Future<String> getSessionId({required String key}) async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get shared preferences instance
    return prefs.getString(key) ?? ""; // Return session ID or empty string
  }

  /// Checks if the user has logged in from shared preferences.
  static Future<bool> getHasLogin({required String key}) async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get shared preferences instance
    return prefs.getBool(key) ?? false; // Return login status or false
  }

  /// Retrieves the account ID from shared preferences using the provided [key].
  static Future<int> getAccountId({required String key}) async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get shared preferences instance
    return prefs.getInt(key) ?? 0; // Return account ID or 0
  }

  /// Deletes the specified key from shared preferences.
  static Future<void> deletePrefs({required String key}) async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get shared preferences instance
    prefs.remove(key); // Remove the specified key
  }
}
