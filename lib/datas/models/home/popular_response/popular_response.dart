import 'dart:convert';

import 'popular_result.dart';

class PopularResponse {
  int? page;
  List<PopularResult>? results;
  int? totalPages;
  int? totalResults;

  PopularResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory PopularResponse.fromMap(Map<String, dynamic> data) {
    return PopularResponse(
      page: data['page'] as int?,
      results: (data['results'] as List<dynamic>?)
          ?.map((e) => PopularResult.fromMap(e as Map<String, dynamic>))
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
  /// Parses the string and returns the resulting Json object as [PopularResponse].
  factory PopularResponse.fromJson(String data) {
    return PopularResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PopularResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
