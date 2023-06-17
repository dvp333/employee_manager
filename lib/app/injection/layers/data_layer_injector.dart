part of '../injector.dart';

void _initializeDataLayer() {
  _registerDataSources();
  _registerRepositories();
}

void _registerRepositories() {
  getIt.registerFactory<EmployeeRepository>(
    () => EmployeeRepositoryImpl(
      preferences: getIt(),
    ),
  );
}

void _registerDataSources() {
  getIt.registerSingletonAsync(() => SharedPreferences.getInstance());
}
