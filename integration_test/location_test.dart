import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:integration_test_permissions/main.dart';
import 'package:location/location.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('displays the current location', (WidgetTester tester) async {
    runApp(LocationApp(
      location: Location(),
    ));

    await tester.pumpAndSettle();
    expect(find.text('Getting location...'), findsOneWidget);
    await tester.pump(Duration(seconds: 10));
    expect(find.textContaining('Location:'), findsOneWidget);
  });
}
