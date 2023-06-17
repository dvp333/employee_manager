part of '../injector.dart';

void _initializeDomainLayer() {
  getIt
    ..registerFactory(() => GetEmployees(
          repository: getIt(),
        ))
    ..registerFactory(
      () => SaveEmployees(
        repository: getIt(),
      ),
    );
}
