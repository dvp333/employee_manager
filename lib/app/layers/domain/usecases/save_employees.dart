import 'package:dartz/dartz.dart';
import 'package:employee_manager/app/layers/domain/entities/employee_list.dart';
import 'package:employee_manager/app/layers/domain/repositories/employee_repository.dart';
import 'package:employee_manager/app/layers/domain/usecases/base/failure.dart';
import 'package:employee_manager/app/layers/domain/usecases/base/usecase.dart';

class SaveEmployees extends UseCase<void, EmployeeList> {
  SaveEmployees({required EmployeeRepository repository})
      : _repository = repository;

  final EmployeeRepository _repository;

  @override
  Future<Either<Failure, void>> run([EmployeeList? p]) async {
    _repository.saveEmployees(p!);
    return right(null);
  }
}
