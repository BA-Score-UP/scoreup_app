import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './pages/login_page.dart';
import './pages/home_page.dart';

Future main() async{
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey
      ),
      initialRoute: Platform.isAndroid? "/login" : "/",
      routes: {
        '/login':(context) => const LoginPage(),
        '/':(context) => const HomePage(account: null,)
      },
      debugShowCheckedModeBanner: false,
    );
  }
}