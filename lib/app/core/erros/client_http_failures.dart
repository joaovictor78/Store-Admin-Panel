import 'package:dio/dio.dart';
import 'general_failures.dart';

class HttClientFailure extends Failure implements DioError {
  final String? msg;
  late final int? statusCode;
  HttClientFailure(DioError err, {this.msg}) {
    statusCode = err.response?.statusCode ?? 400;
    type = err.type;
    error = err.error;
    requestOptions = err.requestOptions;
    response = err.response;
    stackTrace = err.stackTrace;
    type = err.type;
  }

  @override
  dynamic error;

  @override
  late RequestOptions requestOptions;

  @override
  Response? response;

  @override
  StackTrace? stackTrace;

  @override
  late DioErrorType type;

  @override
  String get message => msg ?? response?.statusMessage ?? '';
}

class NoInternetConection extends Failure {
  @override
  final String? message;
  NoInternetConection({
    this.message,
  });
}

class RepositoryFailure extends Failure {
  @override
  final String? message;
  RepositoryFailure({
    this.message,
  });
}
