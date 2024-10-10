import 'dart:convert';

class SessionLoginResponse {
  bool? success;
  String? expiresAt;
  String? requestToken;
  String? statusMessage;

  SessionLoginResponse(
      {this.success, this.expiresAt, this.requestToken, this.statusMessage});

  factory SessionLoginResponse.fromMap(Map<String, dynamic> data) {
    return SessionLoginResponse(
      success: data['success'] as bool?,
      expiresAt: data['expires_at'] as String?,
      requestToken: data['request_token'] as String?,
      statusMessage: data['status_message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
        'expires_at': expiresAt,
        'request_token': requestToken,
        'status_message': statusMessage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SessionLoginResponse].
  factory SessionLoginResponse.fromJson(String data) {
    return SessionLoginResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SessionLoginResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
