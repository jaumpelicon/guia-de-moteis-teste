import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_motel_teste/config/localization/localize.dart';
import 'package:guia_de_motel_teste/domain/suite/suite_categories_entity.dart';
import 'package:guia_de_motel_teste/domain/suite/suite_entity.dart';
import 'package:guia_de_motel_teste/domain/suite/suite_item_entity.dart';
import 'package:guia_de_motel_teste/domain/suite/suite_period_entity.dart';
import 'package:guia_de_motel_teste/ui/home_screen/components/motel_item/motel_item.dart';
import 'package:guia_de_motel_teste/ui/home_screen/components/suite_item/suite_item.dart';
import 'package:guia_de_motel_teste/utils/service_locator/service_locator.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../config/localization/localize_mock.dart';
import '../../../../data/repositorys/motels_repository_test.mocks.dart';

void main() {
  final motelMock = MockMotelEntity();
  final localizationMock = LocalizeMock.instance;
  ServiceLocator.registerSingleton<LocalizeProtocol>(localizationMock);

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

  testWidgets('motel item widget tests', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
            home: Column(children: [
          MotelItem(
            motel: motelMock,
          ),
        ])),
      );
    });
    expect(find.text(motelMock.fantasia), findsOneWidget);
    expect(find.text(motelMock.bairro), findsOneWidget);
    expect(find.byType(ExpandablePageView), findsOneWidget);
    expect(find.byType(SuiteItem), findsOneWidget);
  });
}
