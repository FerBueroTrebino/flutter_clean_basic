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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBI_y1VHqvEDttwFB968C-Faj1BSlZiz-Q',
    appId: '1:105523419023:web:4659e88a2b4ce17fea9dfa',
    messagingSenderId: '105523419023',
    projectId: 'dayoff-bc180',
    authDomain: 'dayoff-bc180.firebaseapp.com',
    storageBucket: 'dayoff-bc180.appspot.com',
    measurementId: 'G-1YG4SGVGCW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZSHH7x__CyOiDwVNBbaZtdWiL3-JRm0s',
    appId: '1:105523419023:android:7e85f55a0a8b8e6aea9dfa',
    messagingSenderId: '105523419023',
    projectId: 'dayoff-bc180',
    storageBucket: 'dayoff-bc180.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKl7rwz91EzXeAowWxuy53Cmc95ciwPmQ',
    appId: '1:105523419023:ios:fb2e9e0110661c26ea9dfa',
    messagingSenderId: '105523419023',
    projectId: 'dayoff-bc180',
    storageBucket: 'dayoff-bc180.appspot.com',
    iosClientId: '105523419023-6j93lc6pmi3vdu8jb1ufqucl87g63qcg.apps.googleusercontent.com',
    iosBundleId: 'com.dayoffapp.dayoff',
  );
}
