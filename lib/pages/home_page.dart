import 'package:flutter/material.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import './select_questions_page.dart';
import '../widgets/container_button_widget.dart';

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
            ContainerButton(
              title: 'Meta Semanal', 
              onPressed: () {},
            ),
            ContainerButton(
              title: 'Taxa de Acertos', 
              onPressed: () {},
            ),
            ContainerButton(
              title: 'Testar Conhecimentos', 
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectQuestions()));
              },
            ),
            ContainerButton(
              title: 'Revisar Questões', 
              onPressed: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Nav(),
    );
  }
}