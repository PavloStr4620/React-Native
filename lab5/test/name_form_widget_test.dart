import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab5/name_form.dart';

void main() {
  testWidgets('Shows greeting on valid input', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: NameForm())));

    await tester.enterText(find.byKey(Key('firstNameField')), 'Іван');
    await tester.enterText(find.byKey(Key('lastNameField')), 'Петренко');
    await tester.tap(find.byKey(Key('submitButton')));
    await tester.pump();

    expect(find.text('Привіт, Іван Петренко!'), findsOneWidget);
  });
}

