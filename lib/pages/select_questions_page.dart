import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../pages/exam_page.dart';
import '../widgets/dropdown_widget.dart';
import '../models/question_models.dart';
import '../models/subject_models.dart';
import '../services/get_question_ammount_by_subjects.dart';
import '../services/get_filtered_questions.dart';

class SelectQuestions extends StatefulWidget {
  final SubjectListModel? macroSubjects;

  const SelectQuestions({
    Key? key,
    required this.macroSubjects,
  }) : super(key: key);

  @override
  SelectQuestionsState createState() => SelectQuestionsState();
}

class SelectQuestionsState extends State<SelectQuestions> {
  String? selectedMacroSubject;
  bool isMacroSubjectSelected = false;
  String? selectedMicroSubject;
  int? selectedQuestionAmount;
  String? selectedQuestionAmountValue;

  Future<QuestionListModel?> fetchQuestions(String macroSubject, String microSubject, int quantity) async {
    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }
    QuestionListModel? questions = await getQuestions(apiKey, macroSubject, microSubject, quantity);

    return questions;
  }

  void handleMacroSubjectSelection(String dropdownValue) {
    setState(() {
      isMacroSubjectSelected = true;
      selectedMacroSubject = dropdownValue;
      selectedMicroSubject = null;
      selectedQuestionAmount = null;
      selectedQuestionAmountValue = null;
    });
  }

  Future<int> fetchQuestionAmount(String macroSubject, String microSubject) async {
    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }

    int questionAmount = await getQuestionAmmountBySubjects(
      apiKey,
      macroSubject,
      microSubject,
    );

    return questionAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 16.0,
          children: [
            DropdownWidget(
              title: "Matéria",
              content: widget.macroSubjects!.getCastedMacroSubjects(),
              value: selectedMacroSubject,
              onChange: handleMacroSubjectSelection,
            ),
            DropdownWidget(
              title: "Assunto",
              content: selectedMacroSubject != null
                  ? widget.macroSubjects!
                      .getMacroSubjectByName(selectedMacroSubject!)
                      ?.microSubjects
                      .getCastedMicroSubjects() ?? []
                  : [],
              isEnabled: isMacroSubjectSelected,
              value: selectedMicroSubject,
              onChange: (String value) {
                setState(() {
                  selectedMicroSubject = value;
                  selectedQuestionAmount = null;
                  selectedQuestionAmountValue = null;
                });
              },
            ),
            Visibility(
              visible: selectedMicroSubject != null,
              maintainState: true,
              child: FutureBuilder<int>(
                future: selectedMicroSubject != null
                    ? fetchQuestionAmount(selectedMacroSubject!, selectedMicroSubject!)
                    : Future.value(0),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      color: Colors.blue.shade900,
                    );
                  } else if (snapshot.hasError) {
                    return Text('Ocorreu um erro: ${snapshot.error}');
                  } else {
                    final int? questionAmount = snapshot.data;
                    return Column(
                      children: [
                        DropdownWidget(
                          title: "Quantidade",
                          content: List.generate(questionAmount!, (index) => (index + 1).toString()),
                          value: selectedQuestionAmount?.toString(),
                          onChange: (String value) {
                            setState(() {
                              selectedQuestionAmount = int.parse(value);
                              selectedQuestionAmountValue = value; // Armazena o valor selecionado
                            });
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: ()  async {
                  var questions = await fetchQuestions(
                    selectedMacroSubject!,
                    selectedMicroSubject!,
                    selectedQuestionAmount!,
                  );
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ExamPage(questionList: questions!,)
                  ));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
                ),
                child: const Text(
                  'Selecionar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}