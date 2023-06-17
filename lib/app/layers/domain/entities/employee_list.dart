import 'package:employee_manager/app/layers/domain/entities/employee.dart';

class EmployeeList {
  List<Employee>? employees;

  EmployeeList({this.employees});

  factory EmployeeList.empty() {
    return EmployeeList(employees: const []);
  }

  EmployeeList.fromJson(Map<String, dynamic> json) {
    if (json['employees'] != null) {
      employees = [];
      json['employees'].forEach((v) {
        employees!.add(Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employees != null) {
      data['employees'] = employees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
