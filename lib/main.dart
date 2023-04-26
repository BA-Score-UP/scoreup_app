import 'package:flutter/material.dart';
import 'package:scoreup_app/src/presentation/pages/home.dart';

void main() {
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
      initialRoute: '/',
      routes: {
        '/':(context) => const HomePage(), //Posteriormente a ordem irá ser trocada.
      },
      debugShowCheckedModeBanner: false,
    );
  }
}