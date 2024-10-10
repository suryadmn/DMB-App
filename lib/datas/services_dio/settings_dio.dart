import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

Future<Response?> configDio(
    {@required endPoint,
    mode = "get",
    authMode,
    path,
    param,
    token,
    apiKey,
    savePath,
    File? file,
    Function(int, String)? onProgress,
    context}) async {
  Response? response;
  String method = mode.toUpperCase();

  try {
    Map<String, String> headers;
    if (mode == "download") {
      headers = {
        HttpHeaders.acceptEncodingHeader: '*',
      };
    } else {
      headers = {
        HttpHeaders.contentTypeHeader: Headers.jsonContentType,
      };
    }
    // Dio options
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
        return status! < 500;
      },
    );

    Dio dio = Dio(options);

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        // Test the intermediate / root cert here. Just ignore it.
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );
    dio.interceptors.add(LogInterceptor(responseBody: true));

    // Adding auth bearer
    if (authMode.toString().toLowerCase() == 'bearer') {
      dio.options.headers['Authorization'] = 'Bearer $token';
      // dio.options.headers['x-api-key'] = apiKey;
    }

    // Http method
    if (mode == "get") {
      response = await dio.get(path, queryParameters: param);
    } else if (mode == "post") {
      response = await dio.post(path, data: param);
    } else if (mode == "patch") {
      response = await dio.patch(path, data: param);
    } else if (mode == "put") {
      response = await dio.put(path, data: param);
    } else if (mode == "delete") {
      response = await dio.delete(path, data: param);
    } else if (mode == "post_raw") {
      response = await dio.post(path, data: param);
    } else if (mode == "download") {
      response = await dio.download(
        endPoint + path,
        savePath,
        queryParameters: param,
        onReceiveProgress: (rcv, total) {
          String downProgress = ((rcv / total) * 100).toStringAsFixed(0);
          onProgress!(total, downProgress);
        },
      );
    }
  } on DioException catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.response != null) {
      response = e.response;

      debugPrint('configDio Dio error!');
      debugPrint('configDio STATUS: ${e.response?.statusCode}');
    } else {
      // Error due to setting up or sending the request
      debugPrint('configDio Error sending request!');

      if (e.type == DioExceptionType.unknown) {
        debugPrint('configDio Error UNKNOWN');
      } else {
        debugPrint('configDio Error ${e.type}');
      }
    }
  }
  return response;
}
