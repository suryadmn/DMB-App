import 'package:shared_preferences/shared_preferences.dart';

/// A helper class to manage shared preferences for storing and retrieving
/// persistent data such as tokens.
class SharedPreferencesHelper {
  /// Key used to store the token in shared preferences.
  static const String prefsTokenKey = 'sharedpref_token_key';

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
}
