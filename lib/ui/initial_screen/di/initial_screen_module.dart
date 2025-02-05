import '../../../utils/service_locator/app_module.dart';
import '../../../utils/service_locator/service_locator.dart';
import '../initial_screen_view.dart';
import '../initial_screen_view_model.dart';

class InitialScreenModule extends AppModule {
  @override
  void registerDependencies() {
    ServiceLocator.registerFactory<InitialScreenProtocol>(() {
      return InitialScreenViewModel();
    });
  }
}
