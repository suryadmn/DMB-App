import 'dart:io';

import 'package:dmb_app/datas/models/home/credits_response/cast.dart';
import 'package:dmb_app/datas/models/home/credits_response/credits_response.dart';
import 'package:dmb_app/datas/models/home/detail_movie_response/detail_movie_response.dart';
import 'package:dmb_app/datas/models/home/similiar_movie_response/similiar_movie_response.dart';
import 'package:dmb_app/utils/color_pallete_helper.dart';
import 'package:dmb_app/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../datas/models/home/now_playing_response/now_playing_response.dart';
import '../datas/models/home/now_playing_response/now_playing_result.dart';
import '../datas/models/home/popular_response/popular_response.dart';
import '../datas/models/home/popular_response/popular_result.dart';
import '../datas/models/home/similiar_movie_response/similiar_movie_result.dart';
import '../datas/models/home/top_rated_response/top_rated_response.dart';
import '../datas/models/home/top_rated_response/top_rated_result.dart';
import '../datas/networking/url_access.dart';
import '../datas/services_dio/settings_dio.dart';

class ProviderHome extends ChangeNotifier {
  bool isLoadingTopRated = false;
  bool isLoadingNowPlaying = false;
  bool isLoadingPopular = false;
  bool isLoadingDownloadImage = false;
  bool isLoadingDetailMovie = false;
  bool isLoadingCredits = false;
  bool isLoadingSimiliarMovie = false;

  // ignore: unused_field
  int _total = 0;
  double _downProgress = 0;

  double get downProgress => _downProgress;

  List<TopRatedResult>? _topRatedResult;
  List<NowPlayingResult>? _nowPlayingResult;
  List<PopularResult>? _popularResult;
  List<Cast>? _castList;
  List<SimilirMovieResult>? _similiarMovieResult;

  List<TopRatedResult> get topRatedResult => _topRatedResult ?? [];
  List<NowPlayingResult> get nowPlayingResult => _nowPlayingResult ?? [];
  List<PopularResult> get popularResult => _popularResult ?? [];
  List<Cast> get castList => _castList ?? [];
  List<SimilirMovieResult> get similiarMovieResult =>
      _similiarMovieResult ?? [];

  DetailMovieResponse? _detailMovieResponse;

  DetailMovieResponse get detailMovie =>
      _detailMovieResponse ?? DetailMovieResponse();

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

  Future<void> downloadAndSaveImageToStorage(
      BuildContext context, String imageUrlPath) async {
    try {
      isLoadingDownloadImage = true;
      notifyListeners();

      // Request storage permission
      var permissionStatus = await storageRequestPermissions();
      if (!permissionStatus.isGranted) {
        // Handle permission denial
        SnackbarHelper.show(context, 'Permission denied',
            backgroundColor: ColorPalleteHelper.warning);
        isLoadingDownloadImage = false;
        notifyListeners();
        return;
      }

      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory(
            '/storage/emulated/0/Download'); // Android "Downloads" folder
      } else if (Platform.isIOS) {
        downloadsDir =
            await getApplicationDocumentsDirectory(); // iOS app-specific directory
      }

      if (downloadsDir != null && await downloadsDir.exists()) {
        // File name based on the image URL
        String fileName = imageUrlPath.split('/').last;

        // Full file path
        String filePath = '${downloadsDir.path}/$fileName';

        // Download the image
        await configDio(
          endPoint: UrlAccess.urlBaseMedia,
          path: imageUrlPath,
          mode: 'download',
          savePath: filePath, // Save to the correct path
          onProgress: (total, progress) {
            updateProgressDownloadFile(context, total, double.parse(progress));
          },
        ).then((response) {
          if (response?.statusCode == 200) {
            isLoadingDownloadImage = false;
            _downProgress = 0.0;

            ScaffoldMessenger.of(context).clearSnackBars();
            // Show a success snackbar
            SnackbarHelper.show(
              context,
              backgroundColor: ColorPalleteHelper.success,
              'Image saved to Downloads folder, do you want to open it?',
              isNeedOpenFile: true,
              openFile: () {
                OpenFile.open(filePath);
              },
            );

            notifyListeners();

            debugPrint("Image downloaded to: $filePath");
          } else {
            isLoadingDownloadImage = false;
            _downProgress = 0.0;

            SnackbarHelper.show(
              context,
              'Failed to download image. Status code: ${response?.statusCode}',
              backgroundColor: ColorPalleteHelper.error,
            );

            notifyListeners();
          }
        }).onError((error, stackTrace) {
          isLoadingDownloadImage = false;
          _downProgress = 0.0;

          SnackbarHelper.show(
            context,
            'An error occurred while downloading the image.',
            textColor: ColorPalleteHelper.white,
            backgroundColor: ColorPalleteHelper.error,
          );

          notifyListeners();
          debugPrint('Download error: $error');
        });
      } else {
        isLoadingDownloadImage = false;
        _downProgress = 0.0;
        notifyListeners();

        debugPrint("Error: Download directory does not exist.");
      }
    } catch (exception) {
      isLoadingDownloadImage = false;
      _downProgress = 0.0;
      notifyListeners();

      debugPrint('Download error: $exception');
    }
  }

  Future<DetailMovieResponse> getMovieDetail({required String movieId}) async {
    isLoadingDetailMovie = true;

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.movies.replaceAll('s', '')}/$movieId',
    ).then((response) {
      if (response?.statusCode == 200) {
        _detailMovieResponse = DetailMovieResponse.fromJson(response?.data);

        isLoadingDetailMovie = false;
      } else {
        isLoadingDetailMovie = false;

        debugPrint(
            'getPopular failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingDetailMovie = false;

      debugPrint('getPopular config error: $error');
    });

    notifyListeners();
    return _detailMovieResponse ?? DetailMovieResponse();
  }

  Future<List<Cast>> getCast({required String movieId}) async {
    isLoadingCredits = true;

    CreditsResponse creditsResponse = CreditsResponse();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.movies.replaceAll('s', '')}/$movieId/${UrlAccess.credits}',
    ).then((response) {
      if (response?.statusCode == 200) {
        creditsResponse = CreditsResponse.fromJson(response?.data);
        _castList = creditsResponse.cast ?? [];

        isLoadingCredits = false;
        notifyListeners();
      } else {
        isLoadingCredits = false;
        notifyListeners();

        debugPrint('getCast failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingCredits = false;
      notifyListeners();

      debugPrint('getCast config error: $error');
    });

    return _castList ?? [];
  }

  Future<List<SimilirMovieResult>> getSimilairMovie(
      {required String movieId}) async {
    isLoadingSimiliarMovie = true;

    SimiliarMovieResponse similiarMovieResponse = SimiliarMovieResponse();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.movies.replaceAll('s', '')}/$movieId/${UrlAccess.similar}',
    ).then((response) {
      if (response?.statusCode == 200) {
        similiarMovieResponse = SimiliarMovieResponse.fromJson(response?.data);
        _similiarMovieResult = similiarMovieResponse.results ?? [];

        isLoadingSimiliarMovie = false;
        notifyListeners();
      } else {
        isLoadingSimiliarMovie = false;
        notifyListeners();

        debugPrint(
            'getSimilairMovie failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingSimiliarMovie = false;
      notifyListeners();

      debugPrint('getSimilairMovie config error: $error');
    });

    return _similiarMovieResult ?? [];
  }

  Future<PermissionStatus> storageRequestPermissions() async {
    var status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      // Permission denied, request permission
      return await Permission.manageExternalStorage.request();
    }
    return status; // Permission granted or already granted
  }

  void updateProgressDownloadFile(
      BuildContext context, int total, double downProgress) {
    _total = total;
    _downProgress = downProgress;
    notifyListeners();
  }
}
