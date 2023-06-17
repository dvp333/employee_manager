part of '../injector.dart';

void _initializePresentationLayer() {
  getIt
    ..registerFactory(() => EmployeeListCubit(
          getEmployees: getIt(),
          saveEmployees: getIt(),
        ))
    ..registerFactory(() => AddEmployeeCubit(
          getEmployees: getIt(),
          saveEmployees: getIt(),
        ))
    ..registerFactory(() => MyCalendarCubit());
}
