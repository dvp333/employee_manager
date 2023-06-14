part of '../injector.dart';

void _initializeDataLayer() {
  _registerDataSources();
  _registerRepositories();
}

void _registerRepositories() {
  // getIt.registerFactory<BooksRepository>(
  //   () => BooksRepositoryImpl(
  //     remoteDatasource: getIt(),
  //     localDatasource: getIt(),
  //   ),
  // );
}

void _registerDataSources() {
  // getIt
  //   ..registerSingletonAsync(() => SharedPreferences.getInstance())
  //   ..registerFactory<RemoteBooksDatasource>(
  //     () => RemoteBooksDatasourceImpl(),
  //   )
  //   ..registerFactory<LocalBooksDatasource>(
  //     () => LocalBooksDatasourceImpl(
  //       preferences: getIt(),
  //     ),
  //   );
}
