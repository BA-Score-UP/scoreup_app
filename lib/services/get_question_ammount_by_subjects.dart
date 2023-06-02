import 'package:http/http.dart' as http;
import 'dart:convert';

Future<int> getQuestionAmmountBySubjects(String key, String macroSubject, String microSubject) async {
  Map<String, dynamic> dictBody = {
    'macro_subject': macroSubject,
    if (microSubject.isNotEmpty) 'micro_subject': microSubject,
  };
  String castedBody = jsonEncode(dictBody);
  
  var response = await http.post(
    Uri.parse('https://scoreup-api.onrender.com/subject/get_question_ammount_by_subjects'),
    headers: {
      'Content-Type': 'application/json',
      'Api-Key': key
    },
    body: castedBody,
  );

  if (response.statusCode != 200) {
    throw Exception('Request failed with status: ${response.statusCode}: ${response.body}.');
  }

  int questionAmmount = jsonDecode(response.body)['Ammount'];

  return questionAmmount;
}
