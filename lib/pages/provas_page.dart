import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../pages/exam_page.dart';
import '../models/question_models.dart';
import '../services/get_full_exam.dart';
import '../widgets/container_button_widget.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/drawer_widget.dart';
import '../user_provider.dart';

class ProvasPage extends StatefulWidget {
  const ProvasPage({
    super.key,
  });

  @override
  ProvasPageState createState() => ProvasPageState();
}

class ProvasPageState extends State<ProvasPage> {
  late GoogleSignInAccount user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
  }

  Future<QuestionListModel?> fetchProva(String year, int quantity) async {
    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }

    return await getFullExam(
      apiKey,
      year,
      quantity
    );
  }

  void handleSelection(QuestionListModel? questions) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ExamPage(questionList: questions!),
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
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ContainerButton(
              title: 'ENEM 2022',
              onPressed: () async {
                QuestionListModel? questions = await fetchProva(
                  "2022",
                  175
                );
                if (questions != null) {
                  handleSelection(questions);
                }
              }
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Nav(index: 0,),
    );
  }
}