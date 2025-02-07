import '../../../utils/service_locator/app_module.dart';
import '../../../utils/service_locator/service_locator.dart';
import '../motels_repository.dart';

class RepositorysModule extends AppModule {
  @override
  void registerDependencies() {
    ServiceLocator.registerFactory<MotelsRepositoryProtocol>(() => MotelsRepository());
  }
}
