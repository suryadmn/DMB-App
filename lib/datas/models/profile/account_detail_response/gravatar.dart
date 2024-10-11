import 'dart:convert';

class Gravatar {
  String? hash;

  Gravatar({this.hash});

  factory Gravatar.fromMap(Map<String, dynamic> data) => Gravatar(
        hash: data['hash'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'hash': hash,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Gravatar].
  factory Gravatar.fromJson(String data) {
    return Gravatar.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Gravatar] to a JSON string.
  String toJson() => json.encode(toMap());
}
