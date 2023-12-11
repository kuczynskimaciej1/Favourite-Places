import 'package:develop/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:develop/screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:develop/screens/photos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Defines a bright color scheme for the app using a base color.
///
///[seedColor] sets the color implicitly using the HEX code.
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF7a563f),
);

///Defines a dark color scheme for the app using a base color.
///
///[seedColor] sets the color implicitly using the HEX code.
var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 43, 27, 22),
);

///An entry point of the Flutter application.
///
///[Firebase.initializeApp] initializes Firebase when the app starts.
///The function [runApp] uses Riverpod for state management in the app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
      child: App()));
}


///A class to build the UI of the widget.
///
///Starting from the [darkTheme] attribute, set up with the function [ThemeData.dark().copyWith], settings (such as colors, text styles etc.) apply to the DARK theme.
///A [build] function which returns [MaterialApp] widget is a starting point for a Flutter app.
///An [appBarTheme] attribute of type [AppBarTheme] is an AppBar widget used for displaying a top bar in the app.
///A [titleTextStale] attribute of type [TextStyle] is a Text widget displaying a string of text in the app.
///A [elevatedButtonTheme] attribute of type [ElevatedButtonThemeData] is a Button widget used for handling user interactions.
///A [ElevatedButton.styleFrom] function is a Button widget used for handling user interactions.
///A [titleLarge] attribute of type [TextStyle] is a Text widget displaying a string of text in the app.
///
///Starting from the [theme] attribute, set up with the function [ThemeData.copyWith], settings (such as colors, text styles etc.) apply to the LIGHT theme.
///All other attributes in this group apply the same way as with the dark theme.
///
///A [home] attribute of [StreamBuilder] specifies the home screen widget of the app. It consists of two other attributes: [stream] and [builder].
///The other one, depending on whether some values are assigned, returns three possible paths.
///If [snapshot.connectionState] equals [ConnectionState.waiting], the method [SplashScreen] is returned.
///If [snapshot.hasData] is true, the method [PlacesScreen] is returned.
///Otherwise, the method [AuthScreen] is returned.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AddPlaces',
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: const Color.fromARGB(255, 51, 44, 40),
            foregroundColor: kDarkColorScheme.primary,
            titleTextStyle: const TextStyle().copyWith(
                color: kDarkColorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.onPrimaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kDarkColorScheme.primary,
                fontSize: 16,
              ),
            ),
        iconTheme: const IconThemeData().copyWith(
          color: kDarkColorScheme.primary,
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: const Color(0xFF49362a),
            foregroundColor: kColorScheme.primaryContainer,
            titleTextStyle: const TextStyle().copyWith(
                color: kColorScheme.primaryContainer,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return const PlacesScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}