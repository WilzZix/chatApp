import 'package:chat_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatify',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromRGBO(42, 117, 188, 1),
        accentColor: const Color.fromRGBO(42, 117, 188, 1),
        backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
      ),
      home: const LoginPage(),
    );
  }
}
