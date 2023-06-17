import 'dart:convert';

import 'package:employee_manager/app/layers/domain/entities/employee.dart';
import 'package:employee_manager/app/layers/domain/entities/employee_list.dart';
import 'package:employee_manager/app/layers/domain/repositories/employee_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final SharedPreferences _preferences;
  static const String employeesKey = 'employeesKey';

  EmployeeRepositoryImpl({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  @override
  List<Employee> getEmployees() {
    final json = jsonDecode(_preferences.getString(employeesKey) ?? '{}');
    return EmployeeList.fromJson(json).employees ?? [];
  }

  @override
  void saveEmployees(EmployeeList employees) {
    _preferences.setString(employeesKey, jsonEncode(employees.toJson()));
  }
}
