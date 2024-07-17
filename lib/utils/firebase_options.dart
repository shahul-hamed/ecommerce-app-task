import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDa8Z7pC24VKWVqvpOoQqZHz6IdUFntd00',
    appId: '1:542975237072:android:f43f0fd63f220ad86077d5',
    messagingSenderId: '542975237072',
    projectId: 'eshop-task-1133e',
  );

  static const FirebaseOptions ios = FirebaseOptions(apiKey:"AIzaSyDa8Z7pC24VKWVqvpOoQqZHz6IdUFntd00", appId: "1:542975237072:android:f43f0fd63f220ad86077d5", messagingSenderId: "542975237072",
      projectId:"eshop-task-1133e",
      iosClientId: "542975237072-j16mo7kdjno6e0gffrgc1tqjqbb0hno2.apps.googleusercontent.com",
      androidClientId: "542975237072-avhohv46sa9eod0b8lam48tatf9553i3.apps.googleusercontent.com",
      iosBundleId: "com.app.ecommerce_task"
  );
}