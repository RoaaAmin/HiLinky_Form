
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig{
  static FirebaseOptions get platformOptions{
     if(Platform.isIOS) {
       //ios & mac
       return const FirebaseOptions(
         appId: '1:185653608297:ios:51ac81b1168d0a944e87f8',
         apiKey: 'AIzaSyBDoXAkZ9dwkse-AVdrKRhqcLg6aRpPcu4',
         projectId: 'hilinky-demo',
         messagingSenderId:'185653608297',
         iosBundleId: 'com.example.hilinkyDemo',
       );
     }else{
       //android
       return const FirebaseOptions(
         appId: '1:185653608297:android:99b59739b121e5b94e87f8',
         apiKey: 'AIzaSyCxp9u8Jw3Sf9p0ASSmdjQrd0fqURFTtIQ',
         projectId:'hilinky-demo',
         messagingSenderId: '185653608297',



       );
     }
     }

  }
