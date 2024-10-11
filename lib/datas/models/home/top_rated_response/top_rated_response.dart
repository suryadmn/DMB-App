import 'dart:convert';

import 'top_rated_result.dart';

class TopRatedResponse {
  int? page;
  List<TopRatedResult>? results;
  int? totalPages;
  int? totalResults;

  TopRatedResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TopRatedResponse.fromMap(Map<String, dynamic> data) {
    return TopRatedResponse(
      page: data['page'] as int?,
      results: (data['results'] as List<dynamic>?)
          ?.map((e) => TopRatedResult.fromMap(e as Map<String, dynamic>))
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
  /// Parses the string and returns the resulting Json object as [TopRatedResponse].
  factory TopRatedResponse.fromJson(String data) {
    return TopRatedResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TopRatedResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
