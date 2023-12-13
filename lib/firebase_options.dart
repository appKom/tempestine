// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...


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
    apiKey: 'AIzaSyC-QHS9ig6dhX72xNKxt-aP6ZnbE-GfY88',
    appId: '1:358865722949:web:5ad88b438ae885cfa84d2c',
    messagingSenderId: '358865722949',
    projectId: 'online-appen',
    authDomain: 'online-appen.firebaseapp.com',
    storageBucket: 'online-appen.appspot.com',
    measurementId: 'G-7R51FZW12X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtiC3LoYdau575xSyWV8Y_eUVYbOp06L4',
    appId: '1:358865722949:android:553577a5aa15be23a84d2c',
    messagingSenderId: '358865722949',
    projectId: 'online-appen',
    storageBucket: 'online-appen.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDEBlBdUgZTPVyEu0pZ49euwkz9FTUFXWQ',
    appId: '1:358865722949:ios:b81d5584227bbe00a84d2c',
    messagingSenderId: '358865722949',
    projectId: 'online-appen',
    storageBucket: 'online-appen.appspot.com',
    iosBundleId: 'com.example.onlineEvents',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDEBlBdUgZTPVyEu0pZ49euwkz9FTUFXWQ',
    appId: '1:358865722949:ios:c40eb05ca5ca7d9ba84d2c',
    messagingSenderId: '358865722949',
    projectId: 'online-appen',
    storageBucket: 'online-appen.appspot.com',
    iosBundleId: 'com.example.onlineEvents.RunnerTests',
  );
}
