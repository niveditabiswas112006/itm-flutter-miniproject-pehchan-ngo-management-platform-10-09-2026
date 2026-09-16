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
    apiKey: 'AIzaSyAo7n2xHryJmgHE8CoaHGVeXSiAU9Jb3tM',
    appId: '1:625361155968:web:f8365cdddc1c3e17b0f365',
    messagingSenderId: '625361155968',
    projectId: 'pehchan-ngomanagement-platform',
    authDomain: 'pehchan-ngomanagement-platform.firebaseapp.com',
    storageBucket: 'pehchan-ngomanagement-platform.firebasestorage.app',
    measurementId: 'G-K462703SY8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAo7n2xHryJmgHE8CoaHGVeXSiAU9Jb3tM',
    appId: '1:625361155968:android:a1b2c3d4e5f6', // Mock ID
    messagingSenderId: '625361155968',
    projectId: 'pehchan-ngomanagement-platform',
    storageBucket: 'pehchan-ngomanagement-platform.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAo7n2xHryJmgHE8CoaHGVeXSiAU9Jb3tM',
    appId: '1:625361155968:ios:a1b2c3d4e5f6', // Mock ID
    messagingSenderId: '625361155968',
    projectId: 'pehchan-ngomanagement-platform',
    storageBucket: 'pehchan-ngomanagement-platform.firebasestorage.app',
    iosBundleId: 'com.example.pehchan',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAo7n2xHryJmgHE8CoaHGVeXSiAU9Jb3tM',
    appId: '1:625361155968:ios:a1b2c3d4e5f6', // Mock ID
    messagingSenderId: '625361155968',
    projectId: 'pehchan-ngomanagement-platform',
    storageBucket: 'pehchan-ngomanagement-platform.firebasestorage.app',
    iosBundleId: 'com.example.pehchan',
  );
}
