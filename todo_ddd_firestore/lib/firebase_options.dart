// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBJZEEHV8hoxciMhcLV5pWh3P45bjphkUc',
    appId: '1:788179959190:web:c2bcbbdea44d3e744131b7',
    messagingSenderId: '788179959190',
    projectId: 'noteapp-8bc44',
    authDomain: 'noteapp-8bc44.firebaseapp.com',
    storageBucket: 'noteapp-8bc44.appspot.com',
    measurementId: 'G-ZDLFW0VZQQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZg2uOkG6sTIBcPWXekL8iCH5thsnXCd8',
    appId: '1:788179959190:android:1e5b845b752721fb4131b7',
    messagingSenderId: '788179959190',
    projectId: 'noteapp-8bc44',
    storageBucket: 'noteapp-8bc44.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBap03GTfnoVJW0gcnaiOw77Uk0dp63NOQ',
    appId: '1:788179959190:ios:e206add915654f054131b7',
    messagingSenderId: '788179959190',
    projectId: 'noteapp-8bc44',
    storageBucket: 'noteapp-8bc44.appspot.com',
    iosClientId: '788179959190-foojsf223lsj657c0kbfuqkqlslqdkl8.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoDddFirestore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBap03GTfnoVJW0gcnaiOw77Uk0dp63NOQ',
    appId: '1:788179959190:ios:e206add915654f054131b7',
    messagingSenderId: '788179959190',
    projectId: 'noteapp-8bc44',
    storageBucket: 'noteapp-8bc44.appspot.com',
    iosClientId: '788179959190-foojsf223lsj657c0kbfuqkqlslqdkl8.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoDddFirestore',
  );
}