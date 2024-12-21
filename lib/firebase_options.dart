// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBg44uCTOvN5Vm8PsyG1ioqteb1wqeFJII',
    appId: '1:578883228326:web:760a33edb3019ae9f29a67',
    messagingSenderId: '578883228326',
    projectId: 'controller-app-v1',
    authDomain: 'controller-app-v1.firebaseapp.com',
    storageBucket: 'controller-app-v1.firebasestorage.app',
    measurementId: 'G-RD57QCN0YR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBycIB8T5sWFQRX7AhIrpnugveieMriD8g',
    appId: '1:578883228326:android:67ece865d31f5857f29a67',
    messagingSenderId: '578883228326',
    projectId: 'controller-app-v1',
    storageBucket: 'controller-app-v1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdXJCPqu4pzlaBg6EjT_0dKyDkmtrvfFo',
    appId: '1:578883228326:ios:0270a33ae25cd31cf29a67',
    messagingSenderId: '578883228326',
    projectId: 'controller-app-v1',
    storageBucket: 'controller-app-v1.firebasestorage.app',
    iosBundleId: 'com.example.controllerApp',
  );

}