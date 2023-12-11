import 'package:develop/screens/auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TC000: Test check.', (tester) async {
    //arrange
    await tester.pumpWidget(
      const MaterialApp(),
    );
  });

  testWidgets('TC001: Test incorrect login/email on auth screen.',
      (tester) async {
    //arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AuthScreen(),
        ),
      ),
    );
    var loginTextfield = find.byKey(const Key('login_textfield'));
    var loginButton = find.byKey(const Key('loginButton'));

    // act
    await tester.enterText(loginTextfield, 'test');
    await tester.tap(loginButton);
    await tester.pump();
    //assert
    var text = find.text('Please enter a valid email address.');
    expect(text, findsOneWidget);
  });

  testWidgets('TC002: Test incorrect password on auth screen ', (tester) async {
    //arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AuthScreen(),
        ),
      ),
    );

    var passwordTextfield = find.byKey(const Key('password_textfield'));
    var loginButton = find.byKey(const Key('loginButton'));

    // act
    await tester.enterText(passwordTextfield, 'test');
    await tester.tap(loginButton);
    await tester.pump();
    //assert
    var text = find.text('Password must be at least 6 characters long.');
    expect(text, findsOneWidget);
  });

  testWidgets('TC003: Test incorrect password and login on auth screen ',
      (tester) async {
    //arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AuthScreen(),
        ),
      ),
    );
    var loginTextfield = find.byKey(const Key('login_textfield'));
    var passwordTextfield = find.byKey(const Key('password_textfield'));
    var loginButton = find.byKey(const Key('loginButton'));

    // act
    await tester.enterText(loginTextfield, 'test');
    await tester.enterText(passwordTextfield, 'test');
    await tester.tap(loginButton);
    await tester.pump();
    //assert
    var text = find.text('Please enter a valid email address.');
    var text2 = find.text('Password must be at least 6 characters long.');
    expect(text, findsOneWidget);
    expect(text2, findsOneWidget);
  });

  testWidgets('TC004: Test create account button.', (tester) async {
    //arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AuthScreen(),
        ),
      ),
    );
    var createButton = find.byKey(const Key('createButton'));

    // act
    await tester.tap(createButton);
    await tester.pump();
    //assert
    var text = find.text('I already have an account.');
    expect(text, findsOneWidget);
  });

  // Test Wykonywany manualnie - wizualizacja kroków

  // testWidgets('TC005: Test create account.',
  //     (tester) async {
  //   //arrange

  //   await tester.pumpWidget(
  //     const MaterialApp(
  //       home: Scaffold(
  //         body: AuthScreen(
  //         )

  //       ),
  //     ),
  //   );
  //   var loginTextfield = find.byKey(const Key('login_textfield'));
  //   var passwordTextfield = find.byKey(const Key('password_textfield'));
  //   var loginButton = find.byKey(const Key('loginButton'));
  //   var createButton = find.byKey(const Key('createButton'));

  //   // act

  //   await tester.tap(createButton);
  //   await tester.enterText(loginTextfield, "jakub.had1907@gmail.com");
  //   await tester.enterText(passwordTextfield, "123123");
  //   await tester.tap(loginButton);

  //   await tester.pump();
  //   //assert
  //   var text = find.text('I already have an account.');
  //   expect(text, findsNothing);
  // });

  // Test Wykonywany manualnie - wizualizacja kroków

  // testWidgets('TC006: Test correct password and login on auth screen ',
  //     (tester) async {
  //   //arrange
  //   await tester.pumpWidget(
  //     const MaterialApp(
  //       home: Scaffold(
  //         body: AuthScreen(),
  //       ),
  //     ),
  //   );
  //   var loginTextfield = find.byKey(const Key('login_textfield'));
  //   var passwordTextfield = find.byKey(const Key('password_textfield'));
  //   var loginButton = find.byKey(const Key('loginButton'));

  //   // act
  //   await tester.enterText(loginTextfield, 'jakub.had1907@gmail.com');
  //   await tester.enterText(passwordTextfield, '123123');
  //   await tester.tap(loginButton);
  //   await tester.pump();
  //   //assert

  // });
}
