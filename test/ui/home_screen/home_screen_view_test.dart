import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_motel_teste/config/localization/localize.dart';
import 'package:guia_de_motel_teste/data/http/api_client.dart';
import 'package:guia_de_motel_teste/data/repositorys/motels_repository.dart';
import 'package:guia_de_motel_teste/domain/errors/unexpected_error.dart';
import 'package:guia_de_motel_teste/domain/suite/suite_categories_entity.dart';
import 'package:guia_de_motel_teste/domain/suite/suite_entity.dart';
import 'package:guia_de_motel_teste/domain/suite/suite_item_entity.dart';
import 'package:guia_de_motel_teste/domain/suite/suite_period_entity.dart';
import 'package:guia_de_motel_teste/ui/core/components/error_placeholder.dart';
import 'package:guia_de_motel_teste/ui/home_screen/bloc/home_bloc.dart';
import 'package:guia_de_motel_teste/ui/home_screen/components/home_app_bar/home_app_bar.dart';
import 'package:guia_de_motel_teste/ui/home_screen/components/motel_item/motel_item.dart';
import 'package:guia_de_motel_teste/ui/home_screen/home_screen_view.dart';
import 'package:guia_de_motel_teste/utils/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../config/localization/localize_mock.dart';
import '../../data/repositorys/motels_repository_test.mocks.dart';
import 'home_screen_view_test.mocks.dart';

@GenerateMocks([HomeBloc])
void main() {
  final homeBloc = MockHomeBloc();
  final apiClient = MockApiClient();
  final localizationMock = LocalizeMock.instance;
  final l10n = localizationMock.l10n;
  final motelMock = MockMotelEntity();

  final suiteMock = SuiteEntity(
    nome: 'Suite teste',
    qtd: 1,
    exibirQtdDisponiveis: false,
    fotos: [
      'https://cdn.guiademoteis.com.br/Images/moteis/3148-Motel-Le-Nid/suites/17418-Marselha-Sexy/fotos/64838168-0e40-4087-bc99-445ee4a0754b-suites.jpg',
    ],
    itens: [
      SuiteItemEntity(nome: 'TV a cabo'),
    ],
    categoriaItens: [
      SuiteCategoriesEntity(
        nome: 'Categoria teste',
        icone: 'https://cdn.guiademoteis.com.br/Images/itens-suites/decoracao-erotica-30-10-2023-11-43.png',
      )
    ],
    periodos: [
      SuitePeriodEntity(tempoFormatado: '3 hr', tempo: '3', valor: 180, valorTotal: 180, temCortesia: false),
    ],
  );

  when(motelMock.logo).thenReturn('https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif');
  when(motelMock.fantasia).thenReturn('Motel teste');
  when(motelMock.bairro).thenReturn('bairro teste');
  when(motelMock.suites).thenReturn([suiteMock]);

  ServiceLocator.registerSingleton<LocalizeProtocol>(localizationMock);
  ServiceLocator.registerSingleton<ApiClientProtocol>(apiClient);
  ServiceLocator.registerFactory<MotelsRepositoryProtocol>(() => MotelsRepository());
  ServiceLocator.registerFactory<HomeBloc>(() => homeBloc);

  setUpAll(() {
    provideDummy<HomeState>(HomeInitial());
  });

  testWidgets('home screen view when initialState', (tester) async {
    when(homeBloc.state).thenReturn(HomeInitial());
    when(homeBloc.stream).thenAnswer((_) => Stream.fromIterable([HomeInitial()]));
    await tester.pumpWidget(const MaterialApp(home: HomeScreenView()));
    expect(find.byType(SizedBox), findsOneWidget);
  });

  testWidgets('home screen view when errorState', (tester) async {
    final error = UnexpectedError(errorMessage: 'Error test');
    when(homeBloc.state).thenReturn(HomeError(error: error));
    when(homeBloc.stream).thenAnswer((_) => Stream.fromIterable([HomeError(error: error)]));
    await tester.pumpWidget(const MaterialApp(home: HomeScreenView()));
    expect(find.byType(ErrorPlaceholder), findsOneWidget);
    expect(find.text('Error test'), findsOneWidget);
    expect(find.widgetWithText(TextButton, l10n.tryAgainInputitle), findsOneWidget);
  });

  testWidgets('home screen view when success', (tester) async {
    when(homeBloc.state).thenReturn(HomeSuccess(motels: [motelMock]));
    when(homeBloc.stream).thenAnswer((_) => Stream.fromIterable([
          HomeSuccess(motels: [motelMock])
        ]));
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(home: HomeScreenView()),
      );
    });
    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.byType(HomeAppBar), findsOneWidget);
    expect(find.byType(SliverToBoxAdapter), findsOneWidget);
    expect(find.byType(Divider), findsOneWidget);
    expect(find.byType(MotelItem), findsOneWidget);
  });
}
