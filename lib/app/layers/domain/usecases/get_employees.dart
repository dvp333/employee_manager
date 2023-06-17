import 'package:dartz/dartz.dart';
import 'package:employee_manager/app/layers/domain/entities/employee.dart';
import 'package:employee_manager/app/layers/domain/repositories/employee_repository.dart';
import 'package:employee_manager/app/layers/domain/usecases/base/failure.dart';
import 'package:employee_manager/app/layers/domain/usecases/base/usecase.dart';

class GetEmployees extends UseCase<List<Employee>, NoParams> {
  GetEmployees({required EmployeeRepository repository})
      : _repository = repository;

  final EmployeeRepository _repository;

  @override
  Future<Either<Failure, List<Employee>>> run([NoParams? p]) async {
    return right(_repository.getEmployees());
  }
}
