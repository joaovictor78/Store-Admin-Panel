import '../../../../core/erros/general_failures.dart';

class FailureToUploadProductImage extends GeneralFailure {
  @override
  String? message;
  FailureToUploadProductImage({this.message = ""}) : super(message: message);
}

class FailureToUpdateProductImage extends GeneralFailure {
  @override
  String? message;
  FailureToUpdateProductImage({this.message = ""}) : super(message: message);
}
