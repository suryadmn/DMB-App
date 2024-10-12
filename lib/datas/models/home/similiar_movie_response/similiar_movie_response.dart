import 'dart:convert';

import 'similiar_movie_result.dart';

class SimiliarMovieResponse {
  int? page;
  List<SimilirMovieResult>? results;
  int? totalPages;
  int? totalResults;

  SimiliarMovieResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory SimiliarMovieResponse.fromMap(Map<String, dynamic> data) {
    return SimiliarMovieResponse(
      page: data['page'] as int?,
      results: (data['results'] as List<dynamic>?)
          ?.map((e) => SimilirMovieResult.fromMap(e as Map<String, dynamic>))
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
  /// Parses the string and returns the resulting Json object as [SimiliarMovieResponse].
  factory SimiliarMovieResponse.fromJson(String data) {
    return SimiliarMovieResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SimiliarMovieResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
