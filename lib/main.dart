
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hilinky_demo/pages/hilinky.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );
  runApp(AnimatedLogin());
}

class AnimatedLogin extends StatelessWidget {
  const AnimatedLogin({super.key});

  @override
  Widget build(BuildContext context) {

    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Satoshi'), home: Hilinky()),
    );
  }
}
