import 'dart:convert';

class NowPlayingDates {
  String? maximum;
  String? minimum;

  NowPlayingDates({this.maximum, this.minimum});

  factory NowPlayingDates.fromMap(Map<String, dynamic> data) => NowPlayingDates(
        maximum: data['maximum'] as String?,
        minimum: data['minimum'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'maximum': maximum,
        'minimum': minimum,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NowPlayingDates].
  factory NowPlayingDates.fromJson(String data) {
    return NowPlayingDates.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NowPlayingDates] to a JSON string.
  String toJson() => json.encode(toMap());
}
