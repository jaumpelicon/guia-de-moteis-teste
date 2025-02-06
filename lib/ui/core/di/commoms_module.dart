import '../../../config/localization/localize.dart';
import '../../../utils/service_locator/app_module.dart';
import '../../../utils/service_locator/service_locator.dart';

class CommomsModule extends AppModule {
  @override
  void registerDependencies() {
    ServiceLocator.registerSingleton<LocalizeProtocol>(Localize.instance);
  }
}
