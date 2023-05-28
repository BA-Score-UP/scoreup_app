import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../pages/exam_page.dart';
import '../pages/select_questions_page.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/container_button_widget.dart';
import '../models/subject_models.dart';
import '../models/question_models.dart';
import '../services/get_questions_by_id.dart';
import '../services/get_subjects.dart';
import '../services/get_answer.dart';
import '../services/get_answer_amount.dart';
import 'package:provider/provider.dart';
import '../user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late GoogleSignInAccount user;
  static double sizedBoxWidth = double.infinity;
  static double sizedBoxHeight = 120;
  late double accuracy;
  late int realized;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    fetchStats();
  }

  Future fetchStats() async {
    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }
    int correctAnswers;

    realized = await getAnswerAmount(
      apiKey,
      user.id,
      "",
    );

    correctAnswers = await getAnswerAmount(
      apiKey,
      user.id,
      "correct",
    );

    accuracy = correctAnswers / realized;
    setState(() {
      isLoading = false;
    });
  }

  Future<SubjectListModel> fetchGetSubjects() async {
    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }

    return await getSubjects(apiKey);
  }

  Future<QuestionListModel?>? fetchGetWrongQuestions() async {
    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }

    final userId = user.id;
    List<String> wrongsList = await getAnswer(apiKey, userId, "wrong");
    if (wrongsList.isNotEmpty) {
      return await getQuestionsByIds(apiKey, wrongsList);
    } else {
      return null;
    }
  }

  void handleRevision(QuestionListModel? questions) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ExamPage(questionList: questions!, user: user),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerWidget(),
      appBar: TopBar(
        mainContent: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoUrl!),
            radius: 16,
          ),
          Text("Olá, ${user.displayName}!")
        ],
        isPopAble: false,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade900,
              ),
            )
          : Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                return FutureBuilder<SubjectListModel>(
                  future: fetchGetSubjects(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue.shade900,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final subjects = snapshot.data!;
                      return Container(
                        padding: const EdgeInsets.all(32),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ContainerButton(
                              title: 'Realizadas: $realized',
                              onPressed: () {},
                            ),
                            ContainerButton(
                              title: 'Taxa de Acerto: ${(accuracy * 100).toStringAsFixed(0)}%',
                              onPressed: () {},
                            ),
                            ContainerButton(
                              title: 'Testar Conhecimentos',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectQuestions(
                                      macroSubjects: subjects,
                                      user: user,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ContainerButton(
                              title: 'Revisar Questões',
                              onPressed: () async {
                                QuestionListModel? questions = await fetchGetWrongQuestions();
                                if (questions != null) {
                                  handleRevision(questions);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
            ),
      bottomNavigationBar: const Nav(),
    );
  }
}
