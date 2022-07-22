abstract class Failure implements Exception {
  String? get message;
}

class GeneralFailure implements Failure {
  @override
  String? message;
  GeneralFailure({required this.message});
}
