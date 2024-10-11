import 'dart:convert';

import 'gravatar.dart';
import 'tmdb.dart';

class Avatar {
  Gravatar? gravatar;
  Tmdb? tmdb;

  Avatar({this.gravatar, this.tmdb});

  factory Avatar.fromMap(Map<String, dynamic> data) => Avatar(
        gravatar: data['gravatar'] == null
            ? null
            : Gravatar.fromMap(data['gravatar'] as Map<String, dynamic>),
        tmdb: data['tmdb'] == null
            ? null
            : Tmdb.fromMap(data['tmdb'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'gravatar': gravatar?.toMap(),
        'tmdb': tmdb?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Avatar].
  factory Avatar.fromJson(String data) {
    return Avatar.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Avatar] to a JSON string.
  String toJson() => json.encode(toMap());
}
