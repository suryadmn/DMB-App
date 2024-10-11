import 'dart:convert';

class Tmdb {
  dynamic avatarPath;

  Tmdb({this.avatarPath});

  factory Tmdb.fromMap(Map<String, dynamic> data) => Tmdb(
        avatarPath: data['avatar_path'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'avatar_path': avatarPath,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Tmdb].
  factory Tmdb.fromJson(String data) {
    return Tmdb.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Tmdb] to a JSON string.
  String toJson() => json.encode(toMap());
}
