import 'package:employee_manager/app/injection/injector.dart';
import 'package:employee_manager/app/layers/domain/entities/employee.dart';
import 'package:employee_manager/app/layers/domain/entities/role.dart';
import 'package:employee_manager/app/layers/presentation/add_employee/cubit/add_employee_cubit.dart';
import 'package:employee_manager/app/layers/presentation/add_employee/widgets/bottom_buttons.dart';
import 'package:employee_manager/app/layers/presentation/add_employee/widgets/calendar/cubit/my_calendar_cubit.dart';
import 'package:employee_manager/app/layers/presentation/add_employee/widgets/calendar/my_calendar.dart';
import 'package:employee_manager/app/layers/presentation/add_employee/widgets/my_dropdown_field.dart';
import 'package:employee_manager/utils/date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  static const routeName = '/employees/add';

  static Route<bool> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        final cubit = getIt<AddEmployeeCubit>();
        return BlocProvider(
          create: (context) => cubit,
          child: const AddEmployeePage(),
        );
      },
    );
  }

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  late TextEditingController _nameController;
  Role? _selectedRole;
  DateTime? _selectedStartDay;
  DateTime? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _selectedStartDay = DateTime.now();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(width: 0),
        leadingWidth: 0.0,
        title: const Text(
          'Add Employee Details',
        ),
        elevation: 0,
      ),
      body: BlocListener<AddEmployeeCubit, AddEmployeeState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            final snackBar = SnackBar(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              content: SizedBox(
                  height: 28.0,
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  )),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Column(
          children: [
            _buildFormFields(context),
            const Expanded(child: SizedBox()),
            BottomButtons(
              onTapSave: () {
                context
                    .read<AddEmployeeCubit>()
                    .save(Employee(
                      name: _nameController.text,
                      role: _selectedRole,
                      from: _selectedStartDay,
                      to: _selectedEndDate,
                    ))
                    .then((isOk) {
                  if (isOk) Navigator.of(context).pop();
                });
              },
              onTapCancel: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Employee name',
              hintStyle: const TextStyle(color: Color(0xFF949C9E)),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.5),
                  child: SvgPicture.asset(
                    'assets/images/svg/person.svg',
                  ),
                ),
              ),
              prefixIconConstraints:
                  BoxConstraints.tight(const Size(27.12, 15)),
              prefix: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 9.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(width: 4),
              ),
            ),
          ),
          const SizedBox(height: 23.0),
          MyDropdownField(
            onSelectItem: (role) => _selectedRole = role,
          ),
          const SizedBox(height: 23.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: MyCalendarPicker(
                  dateFormat: dateFormat,
                  initialDay: _selectedStartDay,
                  lastDay: _selectedEndDate,
                  filter: MyCalendarFilter.today,
                  onTapSave: (selectedDay) => setState(() {
                    _selectedStartDay = selectedDay;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19.6),
                child: SvgPicture.asset(
                  'assets/images/svg/arrow_right.svg',
                  width: 13.21,
                ),
              ),
              Expanded(
                child: MyCalendarPicker(
                  dateFormat: dateFormat,
                  firstDay: _selectedStartDay,
                  onTapSave: (selectedDay) => setState(() {
                    _selectedEndDate = selectedDay;
                  }),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
