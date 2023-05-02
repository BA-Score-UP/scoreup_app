import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './pages/home_page.dart';
import './pages/select_questions_page.dart';

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
      initialRoute: '/',
      routes: {
        '/':(context) => const HomePage(),
        '/select_questions':(context) => const SelectQuestions(), //Posteriormente a ordem irá ser trocada.
      },
      debugShowCheckedModeBanner: false,
    );
  }
}