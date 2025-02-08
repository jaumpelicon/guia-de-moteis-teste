import '../../../utils/service_locator/app_module.dart';
import '../../../utils/service_locator/service_locator.dart';
import '../bloc/home_bloc.dart';

class HomeScreenModule extends AppModule {
  @override
  void registerDependencies() {
    ServiceLocator.registerFactory(() => HomeBloc());
  }
}
