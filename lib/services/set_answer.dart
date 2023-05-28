import 'package:http/http.dart' as http;
import 'dart:convert';

Future setAnswer(String key, String userID, String answerID, String status) async {

  Map<String, String> dictBody = {
    'user_ID': userID,
    "answer_ID": answerID,
    "status": status
  };
  String castedBody = jsonEncode(dictBody);
  
  var response = await http.post(
    Uri.parse('https://scoreup-api.onrender.com/user/set_answer'),
    headers: {
      'Content-Type': 'application/json',
      'Api-Key': key
    },
    body: castedBody,
  );

  if (response.statusCode != 200) {
    throw Exception('Request failed with status: ${response.statusCode}: ${response.body}.');
  }

}