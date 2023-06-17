// -----------------------------------------------------------------------------
// Global ServiceLocator
// -----------------------------------------------------------------------------
import 'package:employee_manager/app/layers/data/repositories/employee_repository_impl.dart';
import 'package:employee_manager/app/layers/domain/repositories/employee_repository.dart';
import 'package:employee_manager/app/layers/domain/usecases/get_employees.dart';
import 'package:employee_manager/app/layers/domain/usecases/save_employees.dart';
import 'package:employee_manager/app/layers/presentation/add_employee/cubit/add_employee_cubit.dart';
import 'package:employee_manager/app/layers/presentation/add_employee/widgets/calendar/cubit/my_calendar_cubit.dart';
import 'package:employee_manager/app/layers/presentation/employee_list/cubit/employee_list_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part './layers/data_layer_injector.dart';
part './layers/domain_layer_injector.dart';
part './layers/presentation_layer_injector.dart';
part 'others/others_injector.dart';

GetIt getIt = GetIt.instance;

extension GetItExtension on GetIt {
  void init() {
    _initializeThirdParty();
    _initializePresentationLayer();
    _initializeDomainLayer();
    _initializeDataLayer();
  }
}
