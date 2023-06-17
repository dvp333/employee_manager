part of 'employee_list_cubit.dart';

@immutable
class EmployeeListState with EquatableMixin {
  final List<Employee> employees;
  final String? errorMsg;

  const EmployeeListState({this.employees = const [], this.errorMsg});

  EmployeeListState copyWith({
    List<Employee>? employees,
    String? errorMsg,
  }) {
    return EmployeeListState(
      employees: employees ?? this.employees,
      errorMsg: errorMsg,
    );
  }

  @override
  List<Object?> get props => [...employees, errorMsg];
}
