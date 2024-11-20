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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyA1i_XjCCUp-7nBOzuowHRYMzpCIQKkNkY',
    appId: '1:735616800233:web:abe3b7806de2efa6f92778',
    messagingSenderId: '735616800233',
    projectId: 'runwalk-pussimpur',
    authDomain: 'runwalk-pussimpur.firebaseapp.com',
    storageBucket: 'runwalk-pussimpur.firebasestorage.app',
    measurementId: 'G-32F4MFME6P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDr_tz484pwq4b4uRzHNUrTB3YTWpuRLaQ',
    appId: '1:735616800233:android:3e0e99b0d64f9367f92778',
    messagingSenderId: '735616800233',
    projectId: 'runwalk-pussimpur',
    storageBucket: 'runwalk-pussimpur.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDicjpH4MyZK3CLPHeVn-IjKZgr_IaMIv8',
    appId: '1:735616800233:ios:e1fdc35cb4b67cedf92778',
    messagingSenderId: '735616800233',
    projectId: 'runwalk-pussimpur',
    storageBucket: 'runwalk-pussimpur.firebasestorage.app',
    iosBundleId: 'com.example.trackLariApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDicjpH4MyZK3CLPHeVn-IjKZgr_IaMIv8',
    appId: '1:735616800233:ios:e1fdc35cb4b67cedf92778',
    messagingSenderId: '735616800233',
    projectId: 'runwalk-pussimpur',
    storageBucket: 'runwalk-pussimpur.firebasestorage.app',
    iosBundleId: 'com.example.trackLariApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA1i_XjCCUp-7nBOzuowHRYMzpCIQKkNkY',
    appId: '1:735616800233:web:17dc07e7f5fd5717f92778',
    messagingSenderId: '735616800233',
    projectId: 'runwalk-pussimpur',
    authDomain: 'runwalk-pussimpur.firebaseapp.com',
    storageBucket: 'runwalk-pussimpur.firebasestorage.app',
    measurementId: 'G-LLS6BD0DEZ',
  );
}