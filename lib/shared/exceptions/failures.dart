abstract class Failure {
  String get message;
}

class ServerFailure extends Failure {
  @override
  String get message => 'Sorry, we are having problems with our servers.';
}
