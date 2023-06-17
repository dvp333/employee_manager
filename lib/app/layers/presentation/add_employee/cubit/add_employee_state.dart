part of 'add_employee_cubit.dart';

class AddEmployeeState extends Equatable {
  const AddEmployeeState({this.errorMessage});

  final String? errorMessage;

  AddEmployeeState copyWith({
    String? errorMessage,
  }) {
    return AddEmployeeState(errorMessage: errorMessage);
  }

  @override
  List<Object> get props => [errorMessage ?? ''];
}
