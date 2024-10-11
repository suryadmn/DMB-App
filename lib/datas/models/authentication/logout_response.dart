import 'dart:convert';

class LogoutResponse {
  bool? success;

  LogoutResponse({this.success});

  factory LogoutResponse.fromMap(Map<String, dynamic> data) {
    return LogoutResponse(
      success: data['success'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LogoutResponse].
  factory LogoutResponse.fromJson(String data) {
    return LogoutResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LogoutResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
