import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/subject_models.dart';

Future<SubjectListModel> getSubjects(String key) async {
  var response = await http.get(
    Uri.parse('https://scoreup-api.onrender.com/subject/get_subjects'),
    headers: {'Api-Key': key},
  );

  if (response.statusCode != 200) {
    throw Exception('Request failed with status: ${response.statusCode}: ${response.body}.');
  }

  Map<String, dynamic> rawSubjectMap = jsonDecode(response.body)['Subjects'];
  Map<String, List<String>> castedSubjectMap = {};

  rawSubjectMap.forEach((key, value) {
    List<String> castedValues = List<String>.from(value.map((e) => '$e'));
    castedSubjectMap[key] = castedValues;
  });

  SubjectListModel subjects = SubjectListModel();

  castedSubjectMap.forEach((macroSubject, rawMicroSubjects) {
    MicroSubjectListModel msList = MicroSubjectListModel();
    for (var microSubjectName in rawMicroSubjects) {
      msList.add(MicroSubjectModel(microSubjectName));
    }
    subjects.add(MacroSubjectModel(macroSubject, msList));
  });

  return subjects;
}
