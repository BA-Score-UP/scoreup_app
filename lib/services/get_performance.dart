import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/performance_models.dart';

Future<PerformanceModel> getPerformance(String key, String userID) async {
  Map<String, String> dictBody = {
    'user_ID': userID,
  };
  String castedBody = jsonEncode(dictBody);

  var response = await http.post(
    Uri.parse('https://scoreup-api.onrender.com/statistics/get_user_performance'),
    headers: {
      'Content-Type': 'application/json',
      'Api-Key': key
    },
    body: castedBody,
  );

  if (response.statusCode != 200) {
    throw Exception('Request failed with status: ${response.statusCode}: ${response.body}.');
  }

  var performanceDict = Map<String, dynamic>.from(jsonDecode(response.body)['Performance']);
  Map<String, MicroSubjectPerformanceModel> castedPerformanceDict = performanceDict.map((key, value) {
    return MapEntry(key, MicroSubjectPerformanceModel(
      correct: value['correct'],
      made: value['made'],
    ));
  });

  return PerformanceModel(performanceData: castedPerformanceDict);
}
