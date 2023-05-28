import 'package:http/http.dart' as http;
import 'dart:convert';

Future setUser(String key, String userID) async {

  Map<String, String> dictBody = {
    'user_ID': userID
  };
  String castedBody = jsonEncode(dictBody);
  
  var response = await http.post(
    Uri.parse('https://scoreup-api.onrender.com/user/set_user'),
    headers: {
      'Content-Type': 'application/json',
      'Api-Key': key
    },
    body: castedBody,
  );

  if (response.statusCode != 200 && response.statusCode != 409) {
    throw Exception('Request failed with status: ${response.statusCode}: ${response.body}.');
  }

}