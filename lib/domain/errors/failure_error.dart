abstract class FailureError {
  String get message;
  String? get statusCode;
  Exception? get stackTrace;
}
