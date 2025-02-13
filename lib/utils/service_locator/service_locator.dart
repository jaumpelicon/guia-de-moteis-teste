import 'package:get_it/get_it.dart';

import '../../data/repositorys/di/repositorys_module.dart';
import '../../ui/core/di/commoms_module.dart';
import '../../ui/home_screen/di/home_screen_module.dart';
import 'app_module.dart';

class ServiceLocator {
  ServiceLocator._();

  static final _provider = GetIt.instance;

  static T get<T extends Object>({dynamic param}) {
    return _provider.get<T>(param1: param);
  }

  static void registerSingleton<T extends Object>(T instance) {
    _provider.registerSingleton<T>(instance);
  }

  static void registerLazySingleton<T extends Object>(T Function() constructor) {
    _provider.registerLazySingleton<T>(constructor);
  }

  static void registerFactory<T extends Object>(T Function() constructor) {
    _provider.registerFactory<T>(constructor);
  }

  static void registerFactoryParam<T extends Object, P1>(T Function(P1) constructor) {
    _provider.registerFactoryParam<T, P1, void>(
      (param, _) => constructor(param),
    );
  }

  static void resetLazySingleton<T extends Object>() {
    _provider.resetLazySingleton<T>();
  }

  static bool isRegistered<T extends Object>({
    Object? instance,
  }) {
    return _provider.isRegistered<T>();
  }
}

void initializeDependencies() {
  final appModules = <AppModule>[
    CommomsModule(),
    RepositorysModule(),
    HomeScreenModule(),
  ];

  for (final module in appModules) {
    module.registerDependencies();
  }
}
