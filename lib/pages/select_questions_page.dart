import 'package:flutter/material.dart';
import '../utils/remove_null_util.dart';
import '../models/subject_models.dart';
import '../widgets/dropdown_widget.dart';

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
  String selectedMacroSubject = "";
  bool isMacroSubjectSelected = false;

  void handleMacroSubjectSelection(String dropdownValue) {
    setState(() {
      isMacroSubjectSelected = true;
      selectedMacroSubject = dropdownValue;
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
              title: "Matéria",
              content: macroSubjects!,
              onChange: handleMacroSubjectSelection,
            ),
            DropdownWidget(
              title: "Assunto",
              content: isMacroSubjectSelected?
              removeNull(
                widget.macroSubjects!.getMacroSubjectByName(selectedMacroSubject)!
                .microSubjects.getCastedMicroSubjects()
              )
              :[],
              isEnabled: isMacroSubjectSelected,
            ),
            const DropdownWidget(
              title: "Quantidade",
              content: []
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
