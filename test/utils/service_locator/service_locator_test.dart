import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_motel_teste/config/localization/localize.dart';
import 'package:guia_de_motel_teste/data/http/api_client.dart';
import 'package:guia_de_motel_teste/data/repositorys/motels_repository.dart';
import 'package:guia_de_motel_teste/ui/home_screen/bloc/home_bloc.dart';
import 'package:guia_de_motel_teste/utils/service_locator/service_locator.dart';

void main() {
  testWidgets('service locator tests if register and get instances corretly', (tester) async {
    initializeDependencies();

    expect(ServiceLocator.isRegistered<LocalizeProtocol>(), isTrue);
    expect(ServiceLocator.isRegistered<ApiClientProtocol>(), isTrue);
    expect(ServiceLocator.isRegistered<MotelsRepositoryProtocol>(), isTrue);
    expect(ServiceLocator.isRegistered<HomeBloc>(), isTrue);
  });
}
