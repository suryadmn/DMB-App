import 'dart:convert';

import 'favourite_movie_result.dart';

class FavouriteMovieResponse {
  int? page;
  List<FavouriteMovieResult>? results;
  int? totalPages;
  int? totalResults;

  FavouriteMovieResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory FavouriteMovieResponse.fromMap(Map<String, dynamic> data) {
    return FavouriteMovieResponse(
      page: data['page'] as int?,
      results: (data['results'] as List<dynamic>?)
          ?.map((e) => FavouriteMovieResult.fromMap(e as Map<String, dynamic>))
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
  /// Parses the string and returns the resulting Json object as [FavouriteMovieResponse].
  factory FavouriteMovieResponse.fromJson(String data) {
    return FavouriteMovieResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [FavouriteMovieResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
