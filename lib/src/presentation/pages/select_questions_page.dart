import 'package:flutter/material.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/dropdown_widget.dart';

class SelectQuestions extends StatefulWidget {
  const SelectQuestions({super.key});

  @override
 SelectQuestionsState createState() => SelectQuestionsState();
}

class SelectQuestionsState extends State<SelectQuestions> {

  bool isMacroSubjectSelected = false;

  void handleSelection() {
    setState(() {
      isMacroSubjectSelected = true;
    });
  }

  var items = [
    'Matemática',
    'Português',
    'Inglês',
    'Fisica',
    'Biologia',
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Container (
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownWidget(
              title: "Matéria",
              content: items,
              onChange: () => handleSelection(),
            ),
            DropdownWidget(
              title: "Assunto",
              content: items,
              isEnabled: isMacroSubjectSelected,
            ),
            DropdownWidget(
              title: "Quantidade",
              content: items
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue.shade900)), 
                child: const Text(
                  'Selecionar', 
                style: TextStyle(
                  color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Nav(),
    );
  }
}