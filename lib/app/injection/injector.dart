// -----------------------------------------------------------------------------
// Global ServiceLocator
// -----------------------------------------------------------------------------
import 'package:get_it/get_it.dart';

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
