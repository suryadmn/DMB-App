import 'dart:convert';

class GenerateSessionIdResponse {
  bool? success;
  String? sessionId;

  GenerateSessionIdResponse({this.success, this.sessionId});

  factory GenerateSessionIdResponse.fromMap(Map<String, dynamic> data) {
    return GenerateSessionIdResponse(
      success: data['success'] as bool?,
      sessionId: data['session_id'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
        'session_id': sessionId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GenerateSessionIdResponse].
  factory GenerateSessionIdResponse.fromJson(String data) {
    return GenerateSessionIdResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GenerateSessionIdResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
