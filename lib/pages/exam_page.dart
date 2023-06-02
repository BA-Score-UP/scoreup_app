import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../user_provider.dart';
import './home_page.dart';
import '../services/set_answer.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/bottom_modal_widget.dart';
import '../models/question_models.dart';

class ExamPage extends StatefulWidget {
  final QuestionListModel questionList;

  const ExamPage({
    super.key,
    required this.questionList,
  });

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  late GoogleSignInAccount user;
  late List<QuestionModel> questions;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    questions = widget.questionList.questions;
  }

  void nextQuestion() {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
    });
  }

  void previousQuestion() {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex - 1) % questions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

  Future openModal(String status) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomModal(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Text("Você $status", style: const TextStyle(fontWeight: FontWeight.w700)),
                    status != "Acertou!" ? Text(
                      "Resposta: ${
                        currentQuestion.answer == 0 ? "A":
                        currentQuestion.answer == 1 ? "B":
                        currentQuestion.answer == 2 ? "C":
                        currentQuestion.answer == 3 ? "D":
                        currentQuestion.answer == 4 ? "E":
                        ""
                      }"
                    ):const Text(""),
                    Text("Explicação: ${currentQuestion.explanation}"),
                    ElevatedButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.pop(context);

                        if (questions.isEmpty) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const HomePage())
                          );
                        }

                        nextQuestion();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

    void handleAnswer(int selection) {
      final apiKey = dotenv.env['API-KEY'];
      final String status;

      if (apiKey == null) {
        throw Exception('API-KEY is null');
      }

      if(selection == currentQuestion.answer) {
        status = "correct";
      } else {
        status = "wrong";
      }
      

      setAnswer(
        apiKey,
        user.id,
        currentQuestion.id,
        status
      );
      
      questions.removeWhere((question) => question.id == currentQuestion.id);

      openModal(status == "correct"? "Acertou !" : "Errou");
     
    }

    return Scaffold(
      appBar: const TopBar(),
      body: Padding (
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
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Vestibular: ENEM'),
                      Text('Ano: ${currentQuestion.year}'),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView (
                      child: Column(
                        children: [
                          Text(
                            currentQuestion.statement.text,
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "${currentQuestion.statement.command}:",
              style: const TextStyle(fontWeight: FontWeight.w600)
            ),
            Expanded (
              child: SingleChildScrollView(
                child: Column (
                  children: [
                    ExamButton(
                      action: () => handleAnswer(0),
                      child: Text("A) ${currentQuestion.options[0].toString()}"),
                    ),
                    const SizedBox(height: 8),
                    ExamButton(
                      action: () => handleAnswer(1),
                      child: Text("B) ${currentQuestion.options[1].toString()}"),
                    ),
                    const SizedBox(height: 8),
                    ExamButton(
                      action: () => handleAnswer(2),
                      child: Text("C) ${currentQuestion.options[2].toString()}"),
                    ),
                    const SizedBox(height: 8),
                    ExamButton(
                      action: () => handleAnswer(3),
                      child: Text("D) ${currentQuestion.options[3].toString()}"),
                    ),
                    const SizedBox(height: 8),
                    ExamButton(
                      action: () => handleAnswer(4),
                      child: Text("E) ${currentQuestion.options[4].toString()}",),
                    ),
                  ],
                ),
              ),
            ),
            Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ExamButton(
                  action: previousQuestion,
                  flex: false,
                  child: const Text('Previous'),
                ),
                ExamButton(
                  action: nextQuestion,
                  flex: false,
                  child: const Text('Next'),
                ),
              ]
            )
          ],
        ),
      )
    );
  }
}

class ExamButton extends StatelessWidget {
  final Color background;
  final Function()? action;
  final Widget child;
  final bool flex;

  const ExamButton({
    Key? key,
    this.background = Colors.grey,
    required this.action,
    required this.child,
    this.flex = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(  
      width: flex? double.infinity : 140,
      height: 40,
      child: ElevatedButton(
        onPressed: action,
        child: Align (
          alignment: flex? Alignment.centerLeft : Alignment.center,
          child: child
        ),
      ),
    );
  }
}
