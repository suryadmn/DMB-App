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

/// ProviderProfile is a ChangeNotifier class responsible for managing
/// the state of user profile-related data, such as account details,
/// watchlist movies, and favorite movies.
class ProviderProfile extends ChangeNotifier {
  /// Indicates whether account detail loading is in progress.
  bool isLoadingGetDetailAccount = false;

  /// Indicates whether watchlist movie loading is in progress.
  bool isLoadingWatchListMovie = false;

  /// Indicates whether favorite movie loading is in progress.
  bool isLoadingFavouriteMovie = false;

  /// Indicates whether adding a movie to the watchlist is in progress.
  bool isLoadingAddWatchlist = false;

  /// Indicates whether adding a movie to favorites is in progress.
  bool isLoadingAddFavourite = false;

  /// The account detail response object.
  AccountDetailResponse? _accountDetailResponse;

  /// The list of movies in the watchlist.
  List<WatchlistMovieResult>? _movieListResult;

  /// The list of favorite movies.
  List<FavouriteMovieResult>? _favouriteMovieResult;

  /// Returns the account detail response, or a new instance if null.
  AccountDetailResponse get accountDetailResponse =>
      _accountDetailResponse ?? AccountDetailResponse();

  /// Returns the list of watchlist movies, or an empty list if null.
  List<WatchlistMovieResult> get movieListResult => _movieListResult ?? [];

  /// Returns the list of favorite movies, or an empty list if null.
  List<FavouriteMovieResult> get favouriteMovieResult =>
      _favouriteMovieResult ?? [];

  /// Fetches the account detail for the given [accountId].
  Future<AccountDetailResponse> getAccountDetail({int? accountId}) async {
    isLoadingGetDetailAccount = true; // Start loading state
    notifyListeners();

    // Configures Dio to make the API request for account details
    await configDio(
            endPoint: UrlAccess.urlBase,
            authMode: 'bearer',
            token: UrlAccess.authorization,
            path: '${UrlAccess.apiVersion}${UrlAccess.account}}',
            param: accountId != null ? {'account_id': accountId} : null)
        .then((response) {
      // Check if the response is successful
      if (response?.statusCode == 200) {
        _accountDetailResponse = AccountDetailResponse.fromJson(response?.data);
        isLoadingGetDetailAccount = false; // End loading state
        notifyListeners();
      } else {
        isLoadingGetDetailAccount = false; // End loading state
        notifyListeners();

        debugPrint(
            'getAccountDetail failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingGetDetailAccount = false; // End loading state
      notifyListeners();

      debugPrint('getAccountDetail config error: $error');
    });

    return _accountDetailResponse ??
        AccountDetailResponse(); // Return account details
  }

  /// Fetches the watchlist movies for the given [accountId].
  Future<List<WatchlistMovieResult>> getWatclistMovie({int? accountId}) async {
    isLoadingWatchListMovie = true; // Start loading state
    notifyListeners();

    WatchlistMovieResponse watchlistMovieResponse = WatchlistMovieResponse();

    // Configures Dio to make the API request for watchlist movies
    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.account}${accountId ?? ''}/${UrlAccess.watchlist}${UrlAccess.movies}',
    ).then((response) {
      // Check if the response is successful
      if (response?.statusCode == 200) {
        watchlistMovieResponse =
            WatchlistMovieResponse.fromJson(response?.data);
        _movieListResult =
            watchlistMovieResponse.results ?? []; // Assign results

        isLoadingWatchListMovie = false; // End loading state
        notifyListeners();
      } else {
        isLoadingWatchListMovie = false; // End loading state
        notifyListeners();

        debugPrint(
            'getWatclistMovie failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingWatchListMovie = false; // End loading state
      notifyListeners();

      debugPrint('getWatclistMovie config error: $error');
    });

    return _movieListResult ?? []; // Return the movie list
  }

  /// Fetches the favorite movies for the given [accountId].
  Future<List<WatchlistMovieResult>> getFavouriteMovie({int? accountId}) async {
    isLoadingFavouriteMovie = true; // Start loading state
    notifyListeners();

    FavouriteMovieResponse favouriteMovieResponse = FavouriteMovieResponse();

    // Configures Dio to make the API request for favorite movies
    await configDio(
      endPoint: UrlAccess.urlBase,
      authMode: 'bearer',
      token: UrlAccess.authorization,
      path:
          '${UrlAccess.apiVersion}${UrlAccess.account}${accountId ?? ''}/${UrlAccess.favorite}/${UrlAccess.movies}',
    ).then((response) {
      // Check if the response is successful
      if (response?.statusCode == 200) {
        favouriteMovieResponse =
            FavouriteMovieResponse.fromJson(response?.data);
        _favouriteMovieResult =
            favouriteMovieResponse.results ?? []; // Assign results

        isLoadingFavouriteMovie = false; // End loading state
        notifyListeners();
      } else {
        isLoadingFavouriteMovie = false; // End loading state
        notifyListeners();

        debugPrint(
            'getFavouriteMovie failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingFavouriteMovie = false; // End loading state
      notifyListeners();

      debugPrint('getFavouriteMovie config error: $error');
    });

    return _movieListResult ?? []; // Return the movie list
  }

  /// Adds a movie to the watchlist for the given [accountId] and [movieId].
  Future<AddWatchlistResponse> addWatchlistMovie({
    int? accountId,
    required int movieId,
  }) async {
    isLoadingAddWatchlist = true; // Start loading state
    notifyListeners();

    AddWatchlistResponse addWatchlistResponse = AddWatchlistResponse();

    // Configures Dio to make the API request to add a movie to the watchlist
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
      // Check if the response is successful
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        addWatchlistResponse = AddWatchlistResponse.fromJson(response?.data);
        isLoadingAddWatchlist = false; // End loading state
        notifyListeners();
      } else {
        isLoadingAddWatchlist = false; // End loading state
        notifyListeners();

        debugPrint(
            'addWatchlistMovie failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingAddWatchlist = false; // End loading state
      notifyListeners();

      debugPrint('addWatchlistMovie config error: $error');
    });

    return addWatchlistResponse; // Return the response
  }

  /// Adds a movie to favorites for the given [accountId] and [movieId].
  Future<AddFavouriteResponse> addFavouriteMovie({
    int? accountId,
    required int movieId,
  }) async {
    isLoadingAddFavourite = true; // Start loading state
    notifyListeners();

    AddFavouriteResponse addFavouriteResponse = AddFavouriteResponse();

    // Configures Dio to make the API request to add a movie to favorites
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
      // Check if the response is successful
      if (response?.statusCode == 201) {
        addFavouriteResponse = AddFavouriteResponse.fromJson(response?.data);
        isLoadingAddFavourite = false; // End loading state
        notifyListeners();
      } else {
        isLoadingAddFavourite = false; // End loading state
        notifyListeners();

        debugPrint(
            'addFavouriteMovie failed with status code: ${response?.statusCode}');
      }
    }).onError((error, stackTrace) {
      isLoadingAddFavourite = false; // End loading state
      notifyListeners();

      debugPrint('addFavouriteMovie config error: $error');
    });

    return addFavouriteResponse; // Return the response
  }
}
