import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../utils/remove_null_util.dart';
import '../models/subject_models.dart';
import '../widgets/dropdown_widget.dart';
import '../services/get_question_ammount_by_subjects.dart';

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
  String selectedMacroSubject = '';
  String selectedMicroSubject = '';
  int? microSubjectIndex;
  bool isMacroSubjectSelected = false;
  List<String> questionAmmount = [];

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
                onPressed: () {},
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
