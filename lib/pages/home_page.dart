import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scoreup_app/models/subject_models.dart';
import 'package:scoreup_app/pages/exam_page.dart';
import 'package:scoreup_app/widgets/loading_widget.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import './select_questions_page.dart';
import '../widgets/container_button_widget.dart';
import '../services/get_subjects.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePgeState createState() => HomePgeState();
}

class HomePgeState extends State<HomePage> {
  static double sizedBoxWidth = double.infinity;
  static double sizedBoxHeight = 120;

   Future<SubjectListModel> fetchGetSubjects() async {

    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }
    SubjectListModel subjects = await getSubjects(apiKey);

    return subjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(
        mainContent: [
          Icon(Icons.account_circle_rounded, size: 32,),
          Text("Olá, nome!")
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ContainerButton(
              title: 'Meta Semanal',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ExamPage()));
              },
            ),
            ContainerButton(
              title: 'Taxa de Acertos',
              onPressed: () {},
            ),
            ContainerButton(
              title: 'Testar Conhecimentos',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoadingWidget(
                      future: fetchGetSubjects(),
                      builder: (context, subjects) => SelectQuestions(macroSubjects: subjects),
                    ),
                  ),
                );
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
