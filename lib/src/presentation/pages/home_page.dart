import 'package:flutter/material.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import './select_questions_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static double sizedBoxWidth = double.infinity;
  static double sizedBoxHeight = 120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar( mainContent: [
        Icon(Icons.account_circle_rounded, size: 32,),
        Text("Olá, nome!")
      ]),
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: sizedBoxHeight,
              child: ElevatedButton(
                onPressed: () => {},
                child: const Text(
                  'Meta Semanal',
                  style: TextStyle(fontSize: 20),
                )
              ),
            ),
            SizedBox(
              width: sizedBoxWidth,
              height: sizedBoxHeight,
              child: ElevatedButton(
                onPressed: () => {},
                child: const Text(
                  'Taxa de Acertos',
                  style: TextStyle(fontSize: 20),
                )
              ),
            ),
            SizedBox(
              width: sizedBoxWidth,
              height: sizedBoxHeight,
              child: ElevatedButton(
                onPressed: () => {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectQuestions()))
                },
                child: const Text(
                  'Testar Conhecimentos',
                  style: TextStyle(fontSize: 20),
                )
              ),
            ),
            SizedBox(
              width: sizedBoxWidth,
              height: sizedBoxHeight,
              child: ElevatedButton(
                onPressed: () => {},
                child: const Text(
                  'Revisar Questões',
                  style: TextStyle(fontSize: 20),
                )
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Nav(),
    );
  }
}