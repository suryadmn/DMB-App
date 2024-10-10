import 'package:flutter/material.dart';

import '../datas/models/authentication/generate_token_response.dart';
import '../datas/models/authentication/session_login_response.dart';
import '../datas/networking/url_access.dart';
import '../datas/services_dio/settings_dio.dart';
import '../utils/shared_preferences_helper.dart';

class ProviderAuth extends ChangeNotifier {
  bool isLoadingGenerateToken = false;
  bool isLoadingCreateSession = false;

  Future<GenerateTokenResponse> generateToken() async {
    // Set loading genarate token to true
    isLoadingGenerateToken = true;

    // Initialize model
    GenerateTokenResponse generateTokenResponse = GenerateTokenResponse();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.authentication}${UrlAccess.token}${UrlAccess.newToken}',
    ).then((response) async {
      // Check if response with status code 200
      if (response?.statusCode == 200) {
        generateTokenResponse = GenerateTokenResponse.fromJson(response?.data);

        // Set new generate token to prefs
        await SharedPreferencesHelper.setNewToken(
            token: generateTokenResponse.requestToken ?? "");

        // Set loading genarate token to false
        isLoadingGenerateToken = false;
      } else {
        // Else if status code not 200

        // Set loading genarate token to false
        isLoadingGenerateToken = false;

        debugPrint(
            'generateToken error with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      // If there is error with config

      // Set loading genarate token to false
      isLoadingGenerateToken = false;

      debugPrint('generateToken config error: $error');
    });

    // Update the state
    notifyListeners();

    // Return the data response
    return generateTokenResponse;
  }

  Future<SessionLoginResponse> sessionLogin({
    required BuildContext context,
    required String username,
    required String password,
    required String requestToken,
  }) async {
    // Set loading session login to true
    isLoadingCreateSession = true;
    notifyListeners();

    SessionLoginResponse sessionLoginResponse = SessionLoginResponse();

    await configDio(
        endPoint: UrlAccess.urlBase,
        authMode: 'bearer',
        token: UrlAccess.authorization,
        path:
            '${UrlAccess.apiVersion}${UrlAccess.authentication}${UrlAccess.token}${UrlAccess.validateWithLogin}',
        param: {
          'username': username,
          'password': password,
          'request_token': requestToken
        }).then((response) {
      // Check if response with status code 200
      if (response?.statusCode == 200) {
        sessionLoginResponse = SessionLoginResponse.fromJson(response?.data);

        // Set loading session login to false
        isLoadingCreateSession = false;
      } else if (response?.statusCode == 401) {
        // Else if status code 401

        sessionLoginResponse = SessionLoginResponse.fromJson(response?.data);

        // Set loading session login to false
        isLoadingCreateSession = false;

        debugPrint(
            'generateToken failed login with status code: ${response?.statusCode}');
      } else {
        // Else if status code not 200 and 401

        // Set loading session login to false
        isLoadingCreateSession = false;

        debugPrint(
            'generateToken failed login with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      // If there is error with config

      // Set loading session login to false
      isLoadingCreateSession = false;

      debugPrint('generateToken config error: $error');
    });

    // Update the state
    notifyListeners();

    return sessionLoginResponse;
  }
}
