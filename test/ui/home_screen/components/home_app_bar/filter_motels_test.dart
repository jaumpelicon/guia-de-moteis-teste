import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_motel_teste/ui/core/components/svg_viewer.dart';
import 'package:guia_de_motel_teste/ui/home_screen/components/home_app_bar/filter_motels.dart';

void main() {
  testWidgets('should render FilterMotels with filters and icons', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Column(children: [
          FilterMotels(
            child: SizedBox.shrink(),
          )
        ]),
      ),
    );

    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.text('filtros'), findsOneWidget);
    expect(find.text('com desconto'), findsOneWidget);
    expect(find.text('disponíveis'), findsOneWidget);
    expect(find.text('hidro'), findsOneWidget);
    expect(find.text('piscina'), findsOneWidget);
    expect(find.byType(SvgViewer), findsOneWidget);
  });
}
