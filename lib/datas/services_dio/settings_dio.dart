import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

/// A configurable function that makes HTTP requests using Dio with various options
/// such as authentication, file downloading, and different HTTP methods.
///
/// Parameters:
/// - [endPoint]: The base URL for the request.
/// - [mode]: HTTP method to use (`get`, `post`, `patch`, `put`, `delete`, `download`). Default is `get`.
/// - [authMode]: Type of authentication (`bearer` token) if needed.
/// - [path]: The path for the specific request.
/// - [param]: Query or body parameters for the request.
/// - [token]: Bearer token for authorization if `authMode` is set to `bearer`.
/// - [apiKey]: Optional API key for requests that require additional authentication.
/// - [savePath]: File path to save the downloaded file (for `download` mode).
/// - [file]: File to upload, if applicable.
/// - [onProgress]: Callback for tracking download/upload progress (used in `download` mode).
/// - [context]: Optional context for error handling or logging.
///
/// Returns:
/// - A [Response] object from Dio, or `null` if an error occurs.
///
/// Example usage:
/// ```dart
/// var response = await configDio(
///   endPoint: 'https://api.example.com',
///   mode: 'get',
///   path: '/data',
///   token: 'your_token',
/// );
/// ```
Future<Response?> configDio({
  @required endPoint,
  mode = "get",
  authMode,
  path,
  param,
  token,
  apiKey,
  savePath,
  File? file,
  Function(int, String)? onProgress,
  context,
}) async {
  Response? response;
  String method = mode.toUpperCase();

  try {
    // Set headers depending on mode
    Map<String, String> headers;
    if (mode == "download") {
      headers = {
        HttpHeaders.acceptEncodingHeader: '*', // Allows file downloads
      };
    } else {
      headers = {
        HttpHeaders.contentTypeHeader: Headers.jsonContentType, // JSON content
      };
    }

    // Configure Dio options
    BaseOptions options = BaseOptions(
      baseUrl: endPoint,
      headers: headers,
      method: method,
      responseType: ResponseType.plain,
      connectTimeout: const Duration(milliseconds: 60000),
      sendTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500; // Only accepts status < 500
      },
    );

    Dio dio = Dio(options);

    // Custom HTTP client to handle certificates
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );

    dio.interceptors.add(LogInterceptor(responseBody: true)); // Logs responses

    // Add bearer token if auth mode is 'bearer'
    if (authMode.toString().toLowerCase() == 'bearer') {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    // Handle different HTTP methods
    switch (mode) {
      case "get":
        response = await dio.get(path, queryParameters: param);
        break;
      case "post":
      case "post_raw":
        response = await dio.post(path, data: param);
        break;
      case "patch":
        response = await dio.patch(path, data: param);
        break;
      case "put":
        response = await dio.put(path, data: param);
        break;
      case "delete":
        response = await dio.delete(path, data: param);
        break;
      case "download":
        response = await dio.download(
          endPoint + path,
          savePath,
          queryParameters: param,
          onReceiveProgress: (rcv, total) {
            String downProgress = ((rcv / total) * 100).toStringAsFixed(0);
            onProgress!(
              total,
              downProgress,
            ); // Callback to track download progress
          },
        );
        break;
    }
  } on DioException catch (e) {
    // Handle Dio-specific errors
    if (e.response != null) {
      response = e.response;
      debugPrint('configDio Dio error! STATUS: ${e.response?.statusCode}');
    } else {
      debugPrint('configDio Error sending request! Type: ${e.type}');
      if (e.type == DioExceptionType.unknown) {
        debugPrint('configDio Error UNKNOWN');
      }
    }
  }
  return response;
}
