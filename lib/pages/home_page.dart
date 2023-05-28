import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoreup_app/services/get_answer.dart';
import '../pages/exam_page.dart';
import '../pages/select_questions_page.dart';
import '../widgets/loading_widget.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/container_button_widget.dart';
import '../models/subject_models.dart';
import '../models/question_models.dart';
import '../services/get_questions_by_id.dart';
import '../services/get_subjects.dart';

class HomePage extends StatefulWidget {
  final GoogleSignInAccount? account; 

  const HomePage({
    super.key,
    required this.account
  });

  @override
  HomePgeState createState() => HomePgeState();
}

class HomePgeState extends State<HomePage> {
  static double sizedBoxWidth = double.infinity;
  static double sizedBoxHeight = 120;
  late double accuracy;
  late int realized;

  Future<SubjectListModel> fetchGetSubjects() async {
    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }

    return await getSubjects(
      apiKey
    );
  }

  Future<QuestionListModel?>? fetchGetWronQuestions() async {
    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }
    List<String> wrongsList = await getAnswer(
      apiKey,
      widget.account!.id,
      "wrong"
    );
    if (wrongsList.isNotEmpty){
      return await getQuestionsByIds(
        apiKey,
        wrongsList 
      );
    } else{
      return null;
    }
  }

  void handleRevision(QuestionListModel? questions) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ExamPage(questionList: questions!, user: widget.account!,)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerWidget(),
      appBar: TopBar(
        mainContent: [
          if(widget.account == null)
            const Icon(Icons.account_circle_rounded, size: 32),
          if(widget.account == null)
            const Text("Olá, nome!"),

          if(widget.account != null)
            CircleAvatar(
              backgroundImage: NetworkImage(widget.account!.photoUrl!),
              radius: 16,
            ),
          if(widget.account != null)
            Text("Olá, ${widget.account?.displayName}!")
        ],
        isPopAble: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ContainerButton(
              title: 'Realizadas: 20',
              onPressed: () {},
            ),
            ContainerButton(
              title: 'Taxa de Acerto: 25%',
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
                      builder: (context, subjects) => SelectQuestions(macroSubjects: subjects, user: widget.account,),
                    ),
                  ),
                );
              },
            ),
            ContainerButton(
              title: 'Revisar Questões',
              onPressed: () async {
                QuestionListModel? questions = await fetchGetWronQuestions();
                if (questions != null) {
                  handleRevision(questions);
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Nav(),
    );
  }
}
