import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_motel_teste/ui/core/components/loading_placeholder.dart';

void main() {
  testWidgets('loading placeholder widget tests', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoadingPlaceholder()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
