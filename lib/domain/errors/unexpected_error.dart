import 'failure_error.dart';

class UnexpectedError extends FailureError {
  final String errorMessage;
  final String? code;
  final Exception? nestedException;

  @override
  String get message => errorMessage;

  @override
  String? get statusCode => code;

  @override
  Exception? get stackTrace => nestedException;

  UnexpectedError({
    required this.errorMessage,
    this.code,
    this.nestedException,
  });
}
