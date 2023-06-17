import 'package:dartz/dartz.dart';
import 'package:employee_manager/app/layers/domain/usecases/base/failure.dart';

abstract class UseCase<T, Param> {
  Future<Either<Failure, T>> run([Param? p]);

  Future<Either<Failure, T>> call([Param? p]) async {
    try {
      return await run(p);
    } catch (e) {
      // this place catches unhandled exceptions
      // and here we can sent it to Firebase Crashlytics.
      return left(UnexpectedFailure(e));
    }
  }
}

// Use this class when your use case has no params
class NoParams {}
