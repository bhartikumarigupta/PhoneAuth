import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/splash_screen.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          appId: '1:899062623224:android:cb3604a7d7ddae5b05040d',
          messagingSenderId: '899062623224',
          projectId: 'phoneauth-edf50',
          apiKey: 'AIzaSyDLJC0_K07JuLTcyyzupcIp5CBJnhwjPKw',
          // databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
        ))
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
