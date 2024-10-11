import 'dart:convert';

class AddWatchlistResponse {
  bool? success;
  int? statusCode;
  String? statusMessage;

  AddWatchlistResponse({this.success, this.statusCode, this.statusMessage});

  factory AddWatchlistResponse.fromMap(Map<String, dynamic> data) {
    return AddWatchlistResponse(
      success: data['success'] as bool?,
      statusCode: data['status_code'] as int?,
      statusMessage: data['status_message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
        'status_code': statusCode,
        'status_message': statusMessage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddWatchlistResponse].
  factory AddWatchlistResponse.fromJson(String data) {
    return AddWatchlistResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddWatchlistResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
