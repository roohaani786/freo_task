class ApiCommonError {
  final String? field;
  final String? errorCode;
  final String? message;

  ApiCommonError({
    this.field,
    this.errorCode,
    this.message,
  });

  ApiCommonError copyWith({
    String? field,
    String? errorCode,
    String? message,
  }) =>
      ApiCommonError(
        field: field ?? this.field,
        errorCode: errorCode ?? this.errorCode,
        message: message ?? this.message,
      );

  factory ApiCommonError.fromJson(Map<String, dynamic> json) => ApiCommonError(
        field: json["field"],
        errorCode: json["error_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "field": field,
        "error_code": errorCode,
        "message": message,
      };
}
