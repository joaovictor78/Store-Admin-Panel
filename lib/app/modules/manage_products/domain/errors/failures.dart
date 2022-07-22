import '../../../../core/erros/general_failures.dart';

class FailureThenUploadProductImage extends Failure {
  @override
  String message;
  FailureThenUploadProductImage({this.message = ""});
}
