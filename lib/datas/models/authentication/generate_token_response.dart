import 'dart:convert';

class GenerateTokenResponse {
  bool? success;
  String? expiresAt;
  String? requestToken;

  GenerateTokenResponse({this.success, this.expiresAt, this.requestToken});

  factory GenerateTokenResponse.fromMap(Map<String, dynamic> data) {
    return GenerateTokenResponse(
      success: data['success'] as bool?,
      expiresAt: data['expires_at'] as String?,
      requestToken: data['request_token'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
        'expires_at': expiresAt,
        'request_token': requestToken,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GenerateTokenResponse].
  factory GenerateTokenResponse.fromJson(String data) {
    return GenerateTokenResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GenerateTokenResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
