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

/// A class that manages the home provider functionalities such as fetching movie data.
class ProviderHome extends ChangeNotifier {
  bool isLoadingTopRated = false;
  bool isLoadingNowPlaying = false;
  bool isLoadingPopular = false;
  bool isLoadingDownloadImage = false;
  bool isLoadingDetailMovie = false;
  bool isLoadingCredits = false;
  bool isLoadingSimiliarMovie = false;

  // The total number of items for download progress tracking
  // ignore: unused_field
  int _total = 0;
  double _downProgress = 0;

  /// The current download progress.
  double get downProgress => _downProgress;

  List<TopRatedResult>? _topRatedResult;
  List<NowPlayingResult>? _nowPlayingResult;
  List<PopularResult>? _popularResult;
  List<Cast>? _castList;
  List<SimilirMovieResult>? _similiarMovieResult;

  /// List of top-rated movies.
  List<TopRatedResult> get topRatedResult => _topRatedResult ?? [];

  /// List of currently playing movies.
  List<NowPlayingResult> get nowPlayingResult => _nowPlayingResult ?? [];

  /// List of popular movies.
  List<PopularResult> get popularResult => _popularResult ?? [];

  /// List of movie casts.
  List<Cast> get castList => _castList ?? [];

  /// List of similar movies.
  List<SimilirMovieResult> get similiarMovieResult =>
      _similiarMovieResult ?? [];

  DetailMovieResponse? _detailMovieResponse;

  /// Detailed movie response.
  DetailMovieResponse get detailMovie =>
      _detailMovieResponse ?? DetailMovieResponse();

  /// Fetches top-rated movies from the API.
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

  /// Fetches currently playing movies from the API.
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

  /// Fetches popular movies from the API.
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

  /// Downloads and saves an image to storage.
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

      debugPrint("Download error: $exception");
    }
  }

  /// Fetches movie details based on the provided [id].
  Future<void> getDetailMovie(int id) async {
    isLoadingDetailMovie = true;
    notifyListeners();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.movies.replaceAll('s', '')}/$id',
    ).then((response) {
      if (response?.statusCode == 200) {
        _detailMovieResponse = DetailMovieResponse.fromJson(response?.data);
        isLoadingDetailMovie = false;
        notifyListeners();
      } else {
        isLoadingDetailMovie = false;
        notifyListeners();

        debugPrint(
            'getDetailMovie failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingDetailMovie = false;
      notifyListeners();

      debugPrint('getDetailMovie config error: $error');
    });
  }

  /// Fetches credits for a specific movie based on the provided [id].
  Future<void> getCredits(int id) async {
    isLoadingCredits = true;
    notifyListeners();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.movies.replaceAll('s', '')}/$id/credits',
    ).then((response) {
      if (response?.statusCode == 200) {
        _castList = (CreditsResponse.fromJson(response?.data)).cast ?? [];
        isLoadingCredits = false;
        notifyListeners();
      } else {
        isLoadingCredits = false;
        notifyListeners();

        debugPrint(
            'getCredits failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingCredits = false;
      notifyListeners();

      debugPrint('getCredits config error: $error');
    });
  }

  /// Fetches similar movies based on the provided [id].
  Future<void> getSimiliarMovie(int id) async {
    isLoadingSimiliarMovie = true;
    notifyListeners();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.movies.replaceAll('s', '')}/$id/similar',
    ).then((response) {
      if (response?.statusCode == 200) {
        _similiarMovieResult =
            (SimiliarMovieResponse.fromJson(response?.data)).results ?? [];
        isLoadingSimiliarMovie = false;
        notifyListeners();
      } else {
        isLoadingSimiliarMovie = false;
        notifyListeners();

        debugPrint(
            'getSimiliarMovie failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingSimiliarMovie = false;
      notifyListeners();

      debugPrint('getSimiliarMovie config error: $error');
    });
  }

  /// Updates the download progress.
  void updateProgressDownloadFile(
      BuildContext context, int total, double progress) {
    _total = total;
    _downProgress = progress;
    notifyListeners();
  }

  /// Requests storage permissions.
  Future<PermissionStatus> storageRequestPermissions() async {
    var status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      // Permission denied, request permission
      return await Permission.manageExternalStorage.request();
    }
    return status; // Permission granted or already granted
  }
}
