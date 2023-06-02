import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/question_models.dart';

Future<QuestionListModel?> getQuestionsByIds(String key, List<String> ids) async {
  Map<String, dynamic> dictBody = {
    'questions_ids': ids
  };
  String castedBody = jsonEncode(dictBody);
  
  var response = await http.post(
    Uri.parse('https://scoreup-api.onrender.com/question/get_questions_by_id'),
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