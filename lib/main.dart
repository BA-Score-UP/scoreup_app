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
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 0, 136, 100),
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => const HomePage(),
        '/select_questions':(context) => const SelectQuestions(macroSubjects: null),
      },
      debugShowCheckedModeBanner: false,
    );
  }
} 