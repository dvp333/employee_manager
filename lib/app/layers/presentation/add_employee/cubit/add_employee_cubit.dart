import 'package:employee_manager/app/layers/domain/entities/employee.dart';
import 'package:employee_manager/app/layers/domain/entities/employee_list.dart';
import 'package:employee_manager/app/layers/domain/usecases/base/failure.dart';
import 'package:employee_manager/app/layers/domain/usecases/get_employees.dart';
import 'package:employee_manager/app/layers/domain/usecases/save_employees.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit(
      {required GetEmployees getEmployees,
      required SaveEmployees saveEmployees})
      : _getEmployees = getEmployees,
        _saveEmployees = saveEmployees,
        super(const AddEmployeeState());

  final GetEmployees _getEmployees;
  final SaveEmployees _saveEmployees;

  Future<bool> save(Employee newEmployee) async {
    emit(state.copyWith(errorMessage: null));

    if ((newEmployee.name?.trim().isEmpty ?? true) ||
        newEmployee.role == null ||
        newEmployee.from == null) {
      emit(state.copyWith(
          errorMessage: 'The fields name, role e start date are required.'));
      return false;
    }

    final eitherGetEmployees = await _getEmployees();
    var employees = eitherGetEmployees.fold((failure) => null, (list) => list);
    if (employees != null) {
      final eitherSaveEmployees = await _saveEmployees(
          EmployeeList(employees: [...employees, newEmployee]));
      eitherSaveEmployees.fold(
        (failure) {
          emit(state.copyWith(errorMessage: getErrorMsg(failure)));
        },
        (success) {/* all good */},
      );
    }
    return true;
  }

  String getErrorMsg(failure) {
    var msg = failure.runtimeType.toString();
    if (failure is UnexpectedFailure) {
      msg = failure.error.toString();
    }
    return msg;
  }
}
