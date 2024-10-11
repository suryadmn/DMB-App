import 'package:dmb_app/datas/models/home/add_favourite_response.dart';
import 'package:flutter/material.dart';

import '../datas/models/home/add_watchlist_response.dart';
import '../datas/models/profile/account_detail_response/account_detail_response.dart';
import '../datas/models/profile/favourite_movie_response/favourite_movie_response.dart';
import '../datas/models/profile/favourite_movie_response/favourite_movie_result.dart';
import '../datas/models/profile/watchlist_movie_response/watchlist_movie_response.dart';
import '../datas/models/profile/watchlist_movie_response/watchlist_movie_result.dart';
import '../datas/networking/url_access.dart';
import '../datas/services_dio/settings_dio.dart';

class ProviderProfile extends ChangeNotifier {
  bool isLoadingGetDetailAccount = false;
  bool isLoadingWatchListMovie = false;
  bool isLoadingFavouriteMovie = false;
  bool isLoadingAddWatchlist = false;
  bool isLoadingAddFavourite = false;

  AccountDetailResponse? _accountDetailResponse;
  List<WatchlistMovieResult>? _movieListResult;
  List<FavouriteMovieResult>? _favouriteMovieResult;

  AccountDetailResponse get accountDetailResponse =>
      _accountDetailResponse ?? AccountDetailResponse();
  List<WatchlistMovieResult> get movieListResult => _movieListResult ?? [];
  List<FavouriteMovieResult> get favouriteMovieResult =>
      _favouriteMovieResult ?? [];

  Future<AccountDetailResponse> getAccountDetail({int? accountId}) async {
    isLoadingGetDetailAccount = true;
    notifyListeners();

    await configDio(
            endPoint: UrlAccess.urlBase,
            authMode: 'bearer',
            token: UrlAccess.authorization,
            path: '${UrlAccess.apiVersion}${UrlAccess.account}}',
            param: accountId != null ? {'account_id': accountId} : null)
        .then((response) {
      if (response?.statusCode == 200) {
        _accountDetailResponse = AccountDetailResponse.fromJson(response?.data);

        isLoadingGetDetailAccount = false;
        notifyListeners();
      } else {
        isLoadingGetDetailAccount = false;
        notifyListeners();

        debugPrint(
            'getAccountDetail failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingGetDetailAccount = false;
      notifyListeners();

      debugPrint('getAccountDetail config error: $error');
    });

    return _accountDetailResponse ?? AccountDetailResponse();
  }

  Future<List<WatchlistMovieResult>> getWatclistMovie({int? accountId}) async {
    isLoadingWatchListMovie = true;
    notifyListeners();

    WatchlistMovieResponse watchlistMovieResponse = WatchlistMovieResponse();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.account}${accountId ?? ''}/${UrlAccess.watchlist}${UrlAccess.movies}',
    ).then((response) {
      if (response?.statusCode == 200) {
        watchlistMovieResponse =
            WatchlistMovieResponse.fromJson(response?.data);
        _movieListResult = watchlistMovieResponse.results ?? [];

        isLoadingWatchListMovie = false;
        notifyListeners();
      } else {
        isLoadingWatchListMovie = false;
        notifyListeners();

        debugPrint(
            'getWatclistMovie failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingWatchListMovie = false;
      notifyListeners();

      debugPrint('getWatclistMovie config error: $error');
    });

    return _movieListResult ?? [];
  }

  Future<List<WatchlistMovieResult>> getFavouriteMovie({int? accountId}) async {
    isLoadingFavouriteMovie = true;
    notifyListeners();

    FavouriteMovieResponse favouriteMovieResponse = FavouriteMovieResponse();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.account}${accountId ?? ''}/${UrlAccess.favorite}/${UrlAccess.movies}',
    ).then((response) {
      if (response?.statusCode == 200) {
        favouriteMovieResponse =
            FavouriteMovieResponse.fromJson(response?.data);
        _favouriteMovieResult = favouriteMovieResponse.results ?? [];

        isLoadingFavouriteMovie = false;
        notifyListeners();
      } else {
        isLoadingFavouriteMovie = false;
        notifyListeners();

        debugPrint(
            'getFavouriteMovie failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingFavouriteMovie = false;
      notifyListeners();

      debugPrint('getFavouriteMovie config error: $error');
    });

    return _movieListResult ?? [];
  }

  Future<AddWatchlistResponse> addWatchlistMovie({
    int? accountId,
    required int movieId,
  }) async {
    isLoadingAddWatchlist = true;
    notifyListeners();

    AddWatchlistResponse addWatchlistResponse = AddWatchlistResponse();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      mode: 'post_raw',
      path:
          '${UrlAccess.apiVersion}${UrlAccess.account}${accountId ?? ''}/${UrlAccess.watchlist.replaceAll('/', '')}',
      param: {
        'media_type': 'movie',
        'media_id': movieId,
        'watchlist': true,
      },
    ).then((response) {
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        addWatchlistResponse = AddWatchlistResponse.fromJson(response?.data);

        isLoadingAddWatchlist = false;
        notifyListeners();
      } else {
        isLoadingAddWatchlist = false;
        notifyListeners();

        debugPrint(
            'addWatchlistMovie failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingAddWatchlist = false;
      notifyListeners();

      debugPrint('addWatchlistMovie config error: $error');
    });

    return addWatchlistResponse;
  }

  Future<AddFavouriteResponse> addFavouriteMovie({
    int? accountId,
    required int movieId,
  }) async {
    isLoadingAddFavourite = true;
    notifyListeners();

    AddFavouriteResponse addFavouriteResponse = AddFavouriteResponse();

    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      mode: 'post_raw',
      path:
          '${UrlAccess.apiVersion}${UrlAccess.account}${accountId ?? ''}/${UrlAccess.favorite.replaceAll('/', '')}',
      param: {
        'media_type': 'movie',
        'media_id': movieId,
        'favorite': true,
      },
    ).then((response) {
      if (response?.statusCode == 201) {
        addFavouriteResponse = AddFavouriteResponse.fromJson(response?.data);

        isLoadingAddFavourite = false;
        notifyListeners();
      } else {
        isLoadingAddFavourite = false;
        notifyListeners();

        debugPrint(
            'addFavouriteMovie failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingAddFavourite = false;
      notifyListeners();

      debugPrint('addFavouriteMovie config error: $error');
    });

    return addFavouriteResponse;
  }
}
