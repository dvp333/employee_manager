import 'package:employee_manager/app/layers/domain/entities/employee.dart';
import 'package:employee_manager/app/layers/domain/entities/employee_list.dart';

abstract class EmployeeRepository {
  List<Employee> getEmployees();
  void saveEmployees(EmployeeList employees);
}
