import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDHnBKY-M7kxiHYU-n80P9dXlv3sORvP6U',
    appId: '1:296444278902:web:8f2a9e379ec0d67dafc757',
    messagingSenderId: '296444278902',
    projectId: 'flutter-remem',
    authDomain: 'flutter-remem.firebaseapp.com',
    storageBucket: 'flutter-remem.firebasestorage.app',
    measurementId: 'G-K62MMBTN5Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvKyaHJlmOAO0Hx-wPBu3rRSsmfkmzth8',
    appId: '1:296444278902:android:5dc3381f5b85fa3cafc757',
    messagingSenderId: '296444278902',
    projectId: 'flutter-remem',
    storageBucket: 'flutter-remem.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAF4cUuZTb7fVy0RIeYL7EJpPHsZL4GQxs',
    appId: '1:296444278902:ios:d67b6c1e8a4daaa5afc757',
    messagingSenderId: '296444278902',
    projectId: 'flutter-remem',
    storageBucket: 'flutter-remem.firebasestorage.app',
    iosBundleId: 'com.example.newSample001',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAF4cUuZTb7fVy0RIeYL7EJpPHsZL4GQxs',
    appId: '1:296444278902:ios:d67b6c1e8a4daaa5afc757',
    messagingSenderId: '296444278902',
    projectId: 'flutter-remem',
    storageBucket: 'flutter-remem.firebasestorage.app',
    iosBundleId: 'com.example.newSample001',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDHnBKY-M7kxiHYU-n80P9dXlv3sORvP6U',
    appId: '1:296444278902:web:f1f88b55dd34c0c8afc757',
    messagingSenderId: '296444278902',
    projectId: 'flutter-remem',
    authDomain: 'flutter-remem.firebaseapp.com',
    storageBucket: 'flutter-remem.firebasestorage.app',
    measurementId: 'G-W2ZZLH20QB',
  );

}