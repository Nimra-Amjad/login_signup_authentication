// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myownapp/imageupload/image_upload.dart';
import 'package:myownapp/pages/home.dart';
import 'package:myownapp/pages/login.dart';
import 'package:myownapp/pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDmIZ8sCLnbTrM3Pu-t3PltFQWLCsPXGpo",
          appId: "",
          messagingSenderId: "",
          projectId: "myownapp-62c09",
          storageBucket: "myownapp-62c09.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
