import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_motel_teste/config/localization/localize.dart';
import 'package:guia_de_motel_teste/ui/core/components/svg_viewer.dart';
import 'package:guia_de_motel_teste/ui/home_screen/components/home_app_bar/filter_motels.dart';
import 'package:guia_de_motel_teste/ui/home_screen/components/home_app_bar/home_app_bar.dart';
import 'package:guia_de_motel_teste/utils/service_locator/service_locator.dart';

import '../../../../config/localization/localize_mock.dart';

void main() {
  final localizationMock = LocalizeMock.instance;
  final l10n = localizationMock.l10n;
  ServiceLocator.registerSingleton<LocalizeProtocol>(localizationMock);

  testWidgets('should render HomeAppBar correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              HomeAppBar(),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(SliverAppBar), findsOneWidget);
    expect(find.byType(FilterMotels), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byType(SvgViewer), findsWidgets);
    expect(find.text('Acre'), findsOneWidget);
    expect(find.text(l10n.goNowInputTitle), findsOneWidget);
    expect(find.text(l10n.goLaterInputTitle), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsOneWidget);
  });
}
