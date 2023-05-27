import 'package:flutter/material.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../models/question_models.dart';

class ExamPage extends StatefulWidget {
  final QuestionListModel questionList;

  const ExamPage({
    super.key,
    required this.questionList
  });

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  late List<QuestionModel> questions;

  @override
  void initState() {
    super.initState();
    questions = widget.questionList.questions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Vestibular: ENEM'),
                      Text('Ano: ${questions[0].year}'),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            questions[0].statement.text,
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(
                          minHeight: 60,
                        ),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("A) ${questions[0].options[0].toString()}"),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(
                          minHeight: 60,
                        ),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("B) ${questions[0].options[1].toString()}"),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(
                          minHeight: 60,
                        ),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("C) ${questions[0].options[2].toString()}"),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(
                          minHeight: 60,
                        ),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("D) ${questions[0].options[3].toString()}"),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(
                          minHeight: 60,
                        ),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("E) ${questions[0].options[4].toString()}"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const Nav(),
    );
  }
}
