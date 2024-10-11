import 'package:flutter/material.dart';

import '../datas/models/home/now_playing_response/now_playing_response.dart';
import '../datas/models/home/now_playing_response/now_playing_result.dart';
import '../datas/models/home/popular_response/popular_response.dart';
import '../datas/models/home/popular_response/popular_result.dart';
import '../datas/models/home/top_rated_response/top_rated_response.dart';
import '../datas/models/home/top_rated_response/top_rated_result.dart';
import '../datas/networking/url_access.dart';
import '../datas/services_dio/settings_dio.dart';

class ProviderHome extends ChangeNotifier {
  bool isLoadingTopRated = false;
  bool isLoadingNowPlaying = false;
  bool isLoadingPopular = false;

  List<TopRatedResult>? _topRatedResult;
  List<NowPlayingResult>? _nowPlayingResult;
  List<PopularResult>? _popularResult;

  List<TopRatedResult> get topRatedResult => _topRatedResult ?? [];
  List<NowPlayingResult> get nowPlayingResult => _nowPlayingResult ?? [];
  List<PopularResult> get popularResult => _popularResult ?? [];

  Future<List<TopRatedResult>> getTopRated({int? accountId}) async {
    isLoadingTopRated = true;
    notifyListeners();

    TopRatedResponse topRatedResponse = TopRatedResponse();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.movies.replaceAll('s', '')}/${UrlAccess.topRated}',
    ).then((response) {
      if (response?.statusCode == 200) {
        topRatedResponse = TopRatedResponse.fromJson(response?.data);
        _topRatedResult = topRatedResponse.results ?? [];

        isLoadingTopRated = false;
        notifyListeners();
      } else {
        isLoadingTopRated = false;
        notifyListeners();

        debugPrint(
            'getTopRated failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingTopRated = false;
      notifyListeners();

      debugPrint('getTopRated config error: $error');
    });

    return _topRatedResult ?? [];
  }

  Future<List<TopRatedResult>> getNowPlaying({int? accountId}) async {
    isLoadingNowPlaying = true;
    notifyListeners();

    NowPlayingResponse nowPlayingResponse = NowPlayingResponse();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.movies.replaceAll('s', '')}/${UrlAccess.nowPlaying}',
    ).then((response) {
      if (response?.statusCode == 200) {
        nowPlayingResponse = NowPlayingResponse.fromJson(response?.data);
        _nowPlayingResult = nowPlayingResponse.results ?? [];

        isLoadingNowPlaying = false;
        notifyListeners();
      } else {
        isLoadingNowPlaying = false;
        notifyListeners();

        debugPrint(
            'getNowPlaying failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingNowPlaying = false;
      notifyListeners();

      debugPrint('getNowPlaying config error: $error');
    });

    return _topRatedResult ?? [];
  }

  Future<List<TopRatedResult>> getPopular({int? accountId}) async {
    isLoadingPopular = true;
    notifyListeners();

    PopularResponse popularResponse = PopularResponse();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.movies.replaceAll('s', '')}/${UrlAccess.popular}',
    ).then((response) {
      if (response?.statusCode == 200) {
        popularResponse = PopularResponse.fromJson(response?.data);
        _popularResult = popularResponse.results ?? [];

        isLoadingPopular = false;
        notifyListeners();
      } else {
        isLoadingPopular = false;
        notifyListeners();

        debugPrint(
            'getPopular failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingPopular = false;
      notifyListeners();

      debugPrint('getPopular config error: $error');
    });

    return _topRatedResult ?? [];
  }
}
