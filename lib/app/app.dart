import 'package:employee_manager/app/injection/injector.dart';
import 'package:employee_manager/app/layers/presentation/employee_list/cubit/employee_list_cubit.dart';
import 'package:employee_manager/app/layers/presentation/employee_list/employee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Manager',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
          inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFE5E5E5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),

                // InputBorder(borderSide: BorderSide(color: Color(0xFFE5E5E5)))
              ),
          appBarTheme: Theme.of(context)
              .appBarTheme
              .copyWith(titleTextStyle: const TextStyle(fontSize: 18.0))),
      home: BlocProvider(
        create: (context) {
          final cubit = getIt<EmployeeListCubit>();
          WidgetsBinding.instance
              .addPostFrameCallback((timeStamp) => cubit.getEmployees());
          return cubit;
        },
        child: const EmployeeListPage(title: 'Employee List'),
      ),
    );
  }
}
