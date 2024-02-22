import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/splash_screen.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          appId: '1:996266412497:android:27edd169f775029c00b8f0',
          messagingSenderId: '996266412497',
          projectId: 'phone-79a5a',
          apiKey: 'AIzaSyBCa30AIzt5inZ4tV-_NFKsRU8WtE8awmU',
          // databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
        ))
      : await Firebase.initializeApp();

  runApp(const myapp());
}

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const splash_screen(),
    );
  }
}
