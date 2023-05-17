import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scoreup_app/pages/question_page.dart';
import '../utils/remove_null_util.dart';
import '../models/subject_models.dart';
import '../models/question_models.dart';
import '../widgets/dropdown_widget.dart';
import '../widgets/loading_widget.dart';
import '../services/get_question_ammount_by_subjects.dart';
import '../services/get_filtered_questions.dart';

class SelectQuestions extends StatefulWidget {
  final SubjectListModel? macroSubjects; 

  const SelectQuestions({
    super.key,
    required this.macroSubjects,
  });

  @override
  SelectQuestionsState createState() => SelectQuestionsState();
}

class SelectQuestionsState extends State<SelectQuestions> {
  QuestionListModel? questions;

  String selectedMacroSubject = '';
  String selectedMicroSubject = '';
  int? microSubjectIndex;
  bool isMacroSubjectSelected = false;
  List<String> questionAmmount = [];

  Future<void> fetchQuestions() async {
    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }
    String macroSubject = "Português";
    String microSubject = "Literatura";
    int quantity = 1;

    try {
      QuestionListModel? questionList = await getQuestions(apiKey, macroSubject, microSubject, quantity);
      if (questionList != null) {
        setState(() {
          questions = questionList;
        });
      } else {
        print('No questions found.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void fetchGetQuestionAmmountBySubjects(String macroSubject, String microSubject) async {
    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }

    int quantity = await getQuestionAmmountBySubjects(apiKey, macroSubject, microSubject);

    print(quantity);

    setState(() {
      questionAmmount = List<int>.generate(quantity, (index) => index + 1).map((e) => '$e').toList();
    });
  }

  void handleMacroSubjectSelection(String dropdownValue) {
    setState(() {
      microSubjectIndex = widget.macroSubjects!.getMacroSubjectByName("macroSubject")!.microSubjects.getCastedMicroSubjects().indexOf(dropdownValue);
      isMacroSubjectSelected = true;
      selectedMacroSubject = dropdownValue;
      fetchGetQuestionAmmountBySubjects(
        selectedMacroSubject,
        widget.macroSubjects!.getMacroSubjectByName(dropdownValue)!.microSubjects.getCastedMicroSubjects()[microSubjectIndex!]
      );
    });
  }


  void handleMicroSubjectSelection(String dropdownValue) {
    setState(() {
      selectedMicroSubject = dropdownValue;

      fetchGetQuestionAmmountBySubjects(
        selectedMacroSubject,
        selectedMicroSubject
      );
    });
  }

  

  List<String>? macroSubjects;

  @override
  void initState() {
    super.initState();
    macroSubjects = widget.macroSubjects!.getCastedMacroSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 16.0,
          children: [
            DropdownWidget(
              title: 'Matéria',
              content: macroSubjects!,
              onChange: handleMacroSubjectSelection
            ),
            DropdownWidget(
              title: 'Assunto',
              content: isMacroSubjectSelected?
                removeNull(
                  widget.macroSubjects!.getMacroSubjectByName(selectedMacroSubject)!
                  .microSubjects.getCastedMicroSubjects()
                )
                :[],
              isEnabled: isMacroSubjectSelected,
              onChange: handleMicroSubjectSelection,
            ),
            DropdownWidget(
              title: 'Quantidade',
              content: questionAmmount,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadingWidget(
                        future: fetchQuestions(),
                        builder: (context, subjects,) => ExamPage(questionList: questions!),
                        secondary: false,
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue.shade900)
                ), 
                child: const Text(
                  'Selecionar', 
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
