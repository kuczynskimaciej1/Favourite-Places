// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  ///[FirebaseOptions] for Android.
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcI8QdCVLZvSSanyKK1IV5B07ZVxAKT-M',
    appId: '1:493974950219:android:6bfb1fced6900357cf98ce',
    messagingSenderId: '493974950219',
    projectId: 'projekt-zespolowy-grupa-a7e5b',
    storageBucket: 'projekt-zespolowy-grupa-a7e5b.appspot.com',
  );

  ///[FirebaseOptions] for iOS.
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAy7D0ffBfiw0V9B8Lf-cgCXjCqo-xoflo',
    appId: '1:493974950219:ios:7caa8dac374003b1cf98ce',
    messagingSenderId: '493974950219',
    projectId: 'projekt-zespolowy-grupa-a7e5b',
    storageBucket: 'projekt-zespolowy-grupa-a7e5b.appspot.com',
    iosBundleId: 'com.example.develop',
  );
}
