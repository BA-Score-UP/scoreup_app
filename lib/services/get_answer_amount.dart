import 'package:http/http.dart' as http;
import 'dart:convert';

Future<int> getAnswerAmount(String key, String userID, String status) async {
  Map<String, String> dictBody = {
    'user_ID': userID,
    'status': status,
  };
  String castedBody = jsonEncode(dictBody);

  var response = await http.post(
    Uri.parse('https://scoreup-api.onrender.com/user/get_answer_amount'),
    headers: {
      'Content-Type': 'application/json',
      'Api-Key': key,
    },
    body: castedBody,
  );

  if (response.statusCode != 200) {
    throw Exception('Request failed with status: ${response.statusCode}: ${response.body}.');
  }

  Map<String, dynamic> responseBody = jsonDecode(response.body);
  int? answeredAmmount = responseBody['ammount'];

  return answeredAmmount??0;
}