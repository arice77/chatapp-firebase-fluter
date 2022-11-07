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
    apiKey: 'AIzaSyB9lLtaiji9e4XqWisXnbrGVuweaY7Z5xU',
    appId: '1:518383272256:web:281d4f80e0864138d33aa5',
    messagingSenderId: '518383272256',
    projectId: 'chat-yt-a1b0e',
    authDomain: 'chat-yt-a1b0e.firebaseapp.com',
    storageBucket: 'chat-yt-a1b0e.appspot.com',
    measurementId: 'G-NGGTQ81SNJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3kRluQlYjgb-0_vw-wLKY6NTqfyTJ0LM',
    appId: '1:518383272256:android:a2084ead2ef6f9afd33aa5',
    messagingSenderId: '518383272256',
    projectId: 'chat-yt-a1b0e',
    storageBucket: 'chat-yt-a1b0e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRL8RlQ_TKZ1GYjcH_GCMuMhhEUbtQz1E',
    appId: '1:518383272256:ios:2d9c1403d5ab5fe6d33aa5',
    messagingSenderId: '518383272256',
    projectId: 'chat-yt-a1b0e',
    storageBucket: 'chat-yt-a1b0e.appspot.com',
    iosClientId: '518383272256-v6u4gd8t51921qpeo41k24jle2k1t5qr.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApplicationYt',
  );
}