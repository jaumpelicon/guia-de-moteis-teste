import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_motel_teste/data/repositorys/motels_repository.dart';
import 'package:guia_de_motel_teste/domain/errors/unexpected_error.dart';
import 'package:guia_de_motel_teste/domain/suite/suite_categories_entity.dart';
import 'package:guia_de_motel_teste/domain/suite/suite_entity.dart';
import 'package:guia_de_motel_teste/domain/suite/suite_item_entity.dart';
import 'package:guia_de_motel_teste/domain/suite/suite_period_entity.dart';
import 'package:guia_de_motel_teste/ui/home_screen/bloc/home_bloc.dart';
import 'package:guia_de_motel_teste/utils/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../data/repositorys/motels_repository_test.mocks.dart';
import 'home_bloc_test.mocks.dart';

@GenerateMocks([MotelsRepository])
void main() {
  late HomeBloc homeBloc;
  final MotelsRepositoryProtocol mockRepository = MockMotelsRepository();
  final mockError = UnexpectedError(errorMessage: 'API Failure');
  ServiceLocator.registerFactory<MotelsRepositoryProtocol>(() => mockRepository);
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

  setUp(() {
    homeBloc = HomeBloc();
  });

  group('HomeBloc', () {
    final motelList = [
      motelMock,
    ];

    test('initial state should be HomeInitial', () {
      expect(homeBloc.state, isA<HomeInitial>());
    });

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeSuccess] when getMotels succeeds',
      build: () => homeBloc,
      setUp: () {
        when(mockRepository.getMotels()).thenAnswer((_) async => Right(motelList));
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(GetHomeMotelsEvent()),
      expect: () => [
        HomeLoading(),
        HomeSuccess(motels: motelList),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeError] when getMotels fails',
      build: () => homeBloc,
      setUp: () {
        when(mockRepository.getMotels()).thenAnswer((_) async => Left(mockError));
      },
      act: (bloc) => bloc.add(GetHomeMotelsEvent()),
      expect: () => [
        HomeLoading(),
        HomeError(error: mockError),
      ],
    );
  });
}
