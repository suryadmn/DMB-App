import 'package:dmb_app/datas/models/authentication/generate_session_id_response.dart';
import 'package:dmb_app/datas/models/authentication/logout_response.dart';
import 'package:flutter/material.dart';

import '../datas/models/authentication/generate_token_response.dart';
import '../datas/models/authentication/session_login_response.dart';
import '../datas/networking/url_access.dart';
import '../datas/services_dio/settings_dio.dart';
import '../utils/shared_preferences_helper.dart';

/// Provider class for managing authentication-related logic and state.
class ProviderAuth extends ChangeNotifier {
  bool isLoadingGenerateToken =
      false; // Tracks loading state for generating token
  bool isLoadingCreateSession =
      false; // Tracks loading state for creating session
  bool isLoadingGenerateSessionId =
      false; // Tracks loading state for generating session id
  bool isLoadingLogoutSession =
      false; // Tracks loading state for logout session

  /// Generates a new token by making an API call.
  ///
  /// Returns a [GenerateTokenResponse] with the new token or an empty response
  /// if the API call fails. Updates the loading state accordingly.
  Future<GenerateTokenResponse> generateToken() async {
    // Set loading state for token generation to true
    isLoadingGenerateToken = true;

    // Initialize the token response model
    GenerateTokenResponse generateTokenResponse = GenerateTokenResponse();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.authentication}${UrlAccess.token}${UrlAccess.newToken}',
    ).then((response) async {
      // Check if the response has status code 200 (successful request)
      if (response?.statusCode == 200) {
        generateTokenResponse = GenerateTokenResponse.fromJson(response?.data);

        // Save the new token to shared preferences
        await SharedPreferencesHelper.setNewToken(
            token: generateTokenResponse.requestToken ?? "");

        // Set loading state for token generation to false
        isLoadingGenerateToken = false;
      } else {
        // Handle non-200 status code (request failed)

        // Set loading state for token generation to false
        isLoadingGenerateToken = false;

        debugPrint(
            'generateToken error with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      // Handle any errors during the token generation process

      // Set loading state for token generation to false
      isLoadingGenerateToken = false;

      debugPrint('generateToken config error: $error');
    });

    // Notify listeners to rebuild UI when loading state changes
    notifyListeners();

    // Return the token response (or empty if there was an error)
    return generateTokenResponse;
  }

  /// Attempts to log in by validating the provided username, password, and request token.
  ///
  /// This method performs an API call to create a session. It requires a valid [username],
  /// [password], and [requestToken]. Returns a [SessionLoginResponse] with the session
  /// information or an empty response if the login fails.
  Future<SessionLoginResponse> sessionLogin({
    required BuildContext context, // The context for the widget tree
    required String username, // The username for authentication
    required String password, // The password for authentication
    required String requestToken, // The request token for login validation
  }) async {
    // Set loading state for session creation to true
    isLoadingCreateSession = true;
    notifyListeners();

    // Initialize the session login response model
    SessionLoginResponse sessionLoginResponse = SessionLoginResponse();

    await configDio(
        endPoint: UrlAccess.urlBase,
        authMode: 'bearer',
        token: UrlAccess.authorization,
        mode: 'post_raw',
        path:
            '${UrlAccess.apiVersion}${UrlAccess.authentication}${UrlAccess.token}${UrlAccess.validateWithLogin}',
        param: {
          'username': username, // Username for the login request
          'password': password, // Password for the login request
          'request_token': requestToken // Request token for the login request
        }).then((response) {
      // Check if the response has status code 200 (successful login)
      if (response?.statusCode == 200) {
        sessionLoginResponse = SessionLoginResponse.fromJson(response?.data);

        // Set loading state for session creation to false
        isLoadingCreateSession = false;
      } else if (response?.statusCode == 401) {
        // Handle status code 401 (unauthorized or invalid credentials)
        sessionLoginResponse = SessionLoginResponse.fromJson(response?.data);

        // Set loading state for session creation to false
        isLoadingCreateSession = false;

        debugPrint(
            'sessionLogin failed with status code: ${response?.statusCode}');
      } else {
        // Handle other non-200 status codes (failed request)

        // Set loading state for session creation to false
        isLoadingCreateSession = false;

        debugPrint(
            'sessionLogin failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      // Handle any errors during the session creation process

      // Set loading state for session creation to false
      isLoadingCreateSession = false;

      debugPrint('sessionLogin config error: $error');
    });

    // Notify listeners to rebuild UI when loading state changes
    notifyListeners();

    // Return the session login response (or empty if there was an error)
    return sessionLoginResponse;
  }

  /// Generates a new session ID using the provided request token.
  ///
  /// This method makes an API call to create a session ID. It requires a valid [requestToken].
  /// Returns a [GenerateSessionIdResponse] containing the session ID or an empty response
  /// if the API call fails.
  Future<GenerateSessionIdResponse> generateSessionId(
      {required String requestToken}) async {
    isLoadingGenerateSessionId = true;

    GenerateSessionIdResponse generateSessionIdResponse =
        GenerateSessionIdResponse();

    await configDio(
        endPoint: UrlAccess.urlBase,
        authMode: 'bearer',
        token: UrlAccess.authorization,
        mode: 'post_raw',
        path:
            '${UrlAccess.apiVersion}${UrlAccess.authentication}${UrlAccess.session}${UrlAccess.newSession}',
        param: {
          'request_token': requestToken, // Request token for session generation
        }).then((response) async {
      if (response?.statusCode == 200) {
        generateSessionIdResponse =
            GenerateSessionIdResponse.fromJson(response?.data);

        if (generateSessionIdResponse.success ?? false) {
          // Save the new session ID to shared preferences
          await SharedPreferencesHelper.setNewToken(
              token: generateSessionIdResponse.sessionId ?? "");
        }

        isLoadingGenerateToken = false;
      } else {
        isLoadingGenerateToken = false;

        debugPrint(
            'generateToken error with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingGenerateToken = false;

      debugPrint('generateToken config error: $error');
    });

    // Notify listeners to rebuild UI when loading state changes
    notifyListeners();

    // Return the generated session ID response (or empty if there was an error)
    return generateSessionIdResponse;
  }

  /// Logs out of the current session using the provided session ID.
  ///
  /// This method performs an API call to log out. It requires a valid [sessionId].
  /// Returns a [LogoutResponse] indicating the result of the logout operation.
  Future<LogoutResponse> sessionLogout({
    required String sessionId, // The session ID to log out
  }) async {
    isLoadingLogoutSession = true;
    notifyListeners();

    LogoutResponse logoutResponse = LogoutResponse();

    await configDio(
        endPoint: UrlAccess.urlBase,
        authMode: 'bearer',
        token: UrlAccess.authorization,
        mode: 'delete',
        path:
            '${UrlAccess.apiVersion}${UrlAccess.authentication}${UrlAccess.session.replaceAll('/', '')}',
        param: {'session_id': sessionId} // Session ID for logout request
        ).then((response) {
      if (response?.statusCode == 200) {
        logoutResponse = LogoutResponse.fromJson(response?.data);

        isLoadingLogoutSession = false;
      } else {
        isLoadingLogoutSession = false;

        debugPrint(
            'sessionLogin failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingLogoutSession = false;

      debugPrint('sessionLogin config error: $error');
    });

    // Notify listeners to rebuild UI when loading state changes
    notifyListeners();

    // Return the logout response (or empty if there was an error)
    return logoutResponse;
  }
}
