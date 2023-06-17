abstract class Failure {
  const Failure();
}

class UnexpectedFailure extends Failure {
  final dynamic error;

  UnexpectedFailure(this.error);
}
