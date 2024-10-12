import 'dart:convert';

import 'cast.dart';
import 'crew.dart';

class CreditsResponse {
  int? id;
  List<Cast>? cast;
  List<Crew>? crew;

  CreditsResponse({this.id, this.cast, this.crew});

  factory CreditsResponse.fromMap(Map<String, dynamic> data) {
    return CreditsResponse(
      id: data['id'] as int?,
      cast: (data['cast'] as List<dynamic>?)
          ?.map((e) => Cast.fromMap(e as Map<String, dynamic>))
          .toList(),
      crew: (data['crew'] as List<dynamic>?)
          ?.map((e) => Crew.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'cast': cast?.map((e) => e.toMap()).toList(),
        'crew': crew?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CreditsResponse].
  factory CreditsResponse.fromJson(String data) {
    return CreditsResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CreditsResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
