import 'dart:convert';

class AddFavouriteResponse {
  int? statusCode;
  String? statusMessage;

  AddFavouriteResponse({this.statusCode, this.statusMessage});

  factory AddFavouriteResponse.fromMap(Map<String, dynamic> data) {
    return AddFavouriteResponse(
      statusCode: data['status_code'] as int?,
      statusMessage: data['status_message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'status_code': statusCode,
        'status_message': statusMessage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddFavouriteResponse].
  factory AddFavouriteResponse.fromJson(String data) {
    return AddFavouriteResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddFavouriteResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
