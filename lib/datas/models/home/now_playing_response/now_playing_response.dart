import 'dart:convert';

import 'now_playing_dates.dart';
import 'now_playing_result.dart';

class NowPlayingResponse {
  NowPlayingDates? dates;
  int? page;
  List<NowPlayingResult>? results;
  int? totalPages;
  int? totalResults;

  NowPlayingResponse({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory NowPlayingResponse.fromMap(Map<String, dynamic> data) {
    return NowPlayingResponse(
      dates: data['dates'] == null
          ? null
          : NowPlayingDates.fromMap(data['dates'] as Map<String, dynamic>),
      page: data['page'] as int?,
      results: (data['results'] as List<dynamic>?)
          ?.map((e) => NowPlayingResult.fromMap(e as Map<String, dynamic>))
          .toList(),
      totalPages: data['total_pages'] as int?,
      totalResults: data['total_results'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'dates': dates?.toMap(),
        'page': page,
        'results': results?.map((e) => e.toMap()).toList(),
        'total_pages': totalPages,
        'total_results': totalResults,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NowPlayingResponse].
  factory NowPlayingResponse.fromJson(String data) {
    return NowPlayingResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NowPlayingResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
