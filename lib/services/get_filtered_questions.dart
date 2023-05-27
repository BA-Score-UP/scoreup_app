import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/question_models.dart';

Future<QuestionListModel?> getQuestions(String key, String macroSubject, String microSubject, int quantity) async {
  Map<String, dynamic> dictBody = {
    'macro_subject': macroSubject,
    if (microSubject.isNotEmpty) 'micro_subject': microSubject,
    "quantity": quantity
  };
  String castedBody = jsonEncode(dictBody);
  
  var response = await http.post(
    Uri.parse('https://scoreup-api.onrender.com/question/get_filtered'),
    headers: {
      'Content-Type': 'application/json',
      'Api-Key': key
    },
    body: castedBody,
  );

  if (response.statusCode != 200) {
    throw Exception('Request failed with status: ${response.statusCode}: ${response.body}.');
  }

  Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  QuestionListModel? questionList = QuestionListModel.fromJson(jsonResponse);
  return questionList;
}

void main() async {
  String apiKey = "d4f21202de78628ff239e47e57b44259";
  String macroSubject = "Português";
  int quantity = 3;

  try {
    QuestionListModel? questions = await getQuestions(
      apiKey,
      macroSubject,
      "",
      quantity
    );
    if (questions != null) {
      // Access and process the questions here
      for (QuestionModel question in questions.questions) {
        // Print question details
        print('ID: ${question.id}');
        print('Answer: ${question.answer}');
        print('Explanation: ${question.explanation}');
        print('Macro Subject: ${question.macroSubject}');
        print('Micro Subject: ${question.microSubject}');
        print('Options: ${question.options}');
        print('Statement: ${question.statement}');
        print('Year: ${question.year}');
      }
    } else {
      print('No questions found.');
    }
  } catch (e) {
    print('Error: $e');
  }
}
