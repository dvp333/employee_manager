import 'package:employee_manager/app/layers/domain/entities/employee.dart';
import 'package:employee_manager/app/layers/presentation/add_employee/add_employee_page.dart';
import 'package:employee_manager/app/layers/presentation/employee_list/cubit/employee_list_cubit.dart';
import 'package:employee_manager/utils/date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grouped_list/grouped_list.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  static const floatingButtonSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: BlocConsumer<EmployeeListCubit, EmployeeListState>(
        listener: (context, state) {
          if (state.errorMsg != null) {
            final snackBar = SnackBar(
              content: Text(state.errorMsg!),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return state.employees.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                          image: AssetImage('assets/images/no_employees.png')),
                      Text(
                        'No employee records found',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: GroupedListView<Employee, int>(
                        elements: state.employees,
                        useStickyGroupSeparators: true,
                        itemComparator: (employee1, employee2) {
                          return employee1.name!.compareTo(employee2.name!);
                        },
                        // groupComparator: (value1, value2) => value1.compareTo(value2),
                        groupBy: (element) => element.group,
                        groupSeparatorBuilder: (group) => Container(
                          padding: const EdgeInsets.all(16.0),
                          color: const Color(0xFFE5E5E5),
                          child: Text(
                            group == 0
                                ? 'Current employees'
                                : 'Previous employees',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        itemBuilder: (context, employee) {
                          return Slidable(
                            key: ValueKey(employee.hashCode),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(onDismissed: () {
                                _removeEmployee(context, employee);
                              }),
                              children: [
                                SlidableAction(
                                  onPressed: (ctx) =>
                                      _removeEmployee(context, employee),
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  autoClose: true,
                                ),
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFF2F2F2),
                                      width: 0.5,
                                      style: BorderStyle.solid)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    employee.name ?? '',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    employee.role?.description ?? '',
                                    style: const TextStyle(
                                      color: Color(0xFF949c9E),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Row(
                                    children: [
                                      Text(
                                        'From ${dateFormatWithComma.format(employee.from!)}',
                                        style: const TextStyle(
                                          color: Color(0xFF949c9E),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      if (employee.to != null)
                                        Text(
                                          ' - ${dateFormatWithComma.format(employee.to!)}',
                                          style: const TextStyle(
                                            color: Color(0xFF949c9E),
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 12.0, left: 16.0),
                      width: double.infinity,
                      height: 80.0,
                      color: const Color(0xFFE5E5E5),
                      child: const Text(
                        'Swipe left to delete',
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF949C9E)),
                      ),
                    )
                  ],
                );
        },
      ),
      floatingActionButton: SizedBox(
        height: floatingButtonSize,
        width: floatingButtonSize,
        child: FloatingActionButton(
          heroTag: 'addToSaveButton',
          onPressed: () {
            Navigator.of(context).push(AddEmployeePage.route()).then(
                (value) => context.read<EmployeeListCubit>().getEmployees());
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          elevation: 0,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _removeEmployee(BuildContext context, Employee employee) {
    context.read<EmployeeListCubit>().remove(employee).then((isOk) {
      if (isOk) {
        _showSuccessSnakbar(context, employee);
      }
    });
  }

  void _showSuccessSnakbar(BuildContext context, Employee employee) {
    var cubit = context.read<EmployeeListCubit>();
    final snackBar = SnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      content: SizedBox(
        height: 40.0,
        child: Row(
          children: [
            const Text(
              'Employee data has been deleted',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
            const Expanded(child: SizedBox()),
            TextButton(
              onPressed: () {
                cubit.save(employee);
              },
              child: Text(
                'Undo',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
