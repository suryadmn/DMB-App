import 'dart:convert';

import 'watchlist_movie_result.dart';

class WatchlistMovieResponse {
  int? page;
  List<WatchlistMovieResult>? results;
  int? totalPages;
  int? totalResults;

  WatchlistMovieResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory WatchlistMovieResponse.fromMap(Map<String, dynamic> data) {
    return WatchlistMovieResponse(
      page: data['page'] as int?,
      results: (data['results'] as List<dynamic>?)
          ?.map((e) => WatchlistMovieResult.fromMap(e as Map<String, dynamic>))
          .toList(),
      totalPages: data['total_pages'] as int?,
      totalResults: data['total_results'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'page': page,
        'results': results?.map((e) => e.toMap()).toList(),
        'total_pages': totalPages,
        'total_results': totalResults,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WatchlistMovieResponse].
  factory WatchlistMovieResponse.fromJson(String data) {
    return WatchlistMovieResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WatchlistMovieResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
