import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/registration_page.dart';
import 'package:chat_app/services/db_service.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DBService.instance
        .createUserInDB('0123', 'Nodir', 'nodirbarotov0707@gmail.com');
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Chatify',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromRGBO(42, 117, 188, 1),
        accentColor: const Color.fromRGBO(42, 117, 188, 1),
        backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
      ),
      initialRoute: 'login',
      routes: {
        'login': (BuildContext _context) => LoginPage(),
        'register': (BuildContext _context) => RegistrationPage(),
      },
      home: const RegistrationPage(),
    );
  }
}
