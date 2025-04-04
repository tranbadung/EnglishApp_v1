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
    apiKey: 'AIzaSyDTjVMZYKoEgJy96fbsFGyl_1ml-nhetz0',
    appId: '1:184925991377:web:d26cbb1b6379edabd770f0',
    messagingSenderId: '184925991377',
    projectId: 'authtutorial-5cea9',
    authDomain: 'authtutorial-5cea9.firebaseapp.com',
    storageBucket: 'authtutorial-5cea9.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDnw0QR99EGS7WtYTpX4ZL6AtWg4I_sHWQ',
    appId: '1:184925991377:android:50d7ea44ed0d8333d770f0',
    messagingSenderId: '184925991377',
    projectId: 'authtutorial-5cea9',
    storageBucket: 'authtutorial-5cea9.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEdKWqFRE7Gb0Z49wBvsr0IPAZMtpJu6A',
    appId: '1:184925991377:ios:51c04ca150d119abd770f0',
    messagingSenderId: '184925991377',
    projectId: 'authtutorial-5cea9',
    storageBucket: 'authtutorial-5cea9.firebasestorage.app',
    iosBundleId: 'com.example.doan1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDTjVMZYKoEgJy96fbsFGyl_1ml-nhetz0',
    appId: '1:184925991377:web:b70d2c86095ab266d770f0',
    messagingSenderId: '184925991377',
    projectId: 'authtutorial-5cea9',
    authDomain: 'authtutorial-5cea9.firebaseapp.com',
    storageBucket: 'authtutorial-5cea9.firebasestorage.app',
  );
}
