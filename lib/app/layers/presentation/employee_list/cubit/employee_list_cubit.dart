import 'package:employee_manager/app/layers/domain/entities/employee.dart';
import 'package:employee_manager/app/layers/domain/entities/employee_list.dart';
import 'package:employee_manager/app/layers/domain/usecases/base/failure.dart';
import 'package:employee_manager/app/layers/domain/usecases/get_employees.dart';
import 'package:employee_manager/app/layers/domain/usecases/save_employees.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_list_state.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit(
      {required GetEmployees getEmployees,
      required SaveEmployees saveEmployees})
      : _getEmployees = getEmployees,
        _saveEmployees = saveEmployees,
        super(const EmployeeListState());

  final GetEmployees _getEmployees;
  final SaveEmployees _saveEmployees;

  void getEmployees() async {
    emit(state.copyWith(errorMsg: null));
    var either = await _getEmployees();
    final newState = either.fold(
      (failure) {
        return state.copyWith(
          errorMsg: getErrorMsg(failure),
        );
      },
      (employees) => state.copyWith(employees: employees),
    );

    emit(newState);
  }

  Future<bool> remove(Employee employee) async {
    var itemToRemove = state.employees
        .where((element) => employee.hashCode == element.hashCode)
        .first;
    var newList = [...state.employees];
    newList.remove(itemToRemove);
    final either = await _saveEmployees(EmployeeList(employees: newList));
    final isOK = either.fold(
      (failure) {
        emit(state.copyWith(errorMsg: getErrorMsg(failure)));
        return false;
      },
      (success) => true,
    );
    getEmployees();
    return isOK;
  }

  void save(Employee undoneEmployee) async {
    emit(state.copyWith(errorMsg: null));
    final eitherGetEmployees = await _getEmployees();
    var employees = eitherGetEmployees.fold((failure) => null, (list) => list);
    if (employees != null) {
      if (_hasAlreadyAddedEmployee(employees, undoneEmployee)) return;
      final eitherSaveEmployees = await _saveEmployees(
          EmployeeList(employees: [...employees, undoneEmployee]));
      eitherSaveEmployees.fold(
        (failure) {
          emit(state.copyWith(errorMsg: getErrorMsg(failure)));
        },
        (success) {/* all good */},
      );
    }
    getEmployees();
  }

  bool _hasAlreadyAddedEmployee(
      List<Employee> employees, Employee newEmployee) {
    return employees
        .where((element) => element.name == newEmployee.name)
        .isNotEmpty;
  }

  String getErrorMsg(failure) {
    var msg = failure.runtimeType.toString();
    if (failure is UnexpectedFailure) {
      msg = failure.error.toString();
    }
    return msg;
  }
}
