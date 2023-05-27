class QuestionListModel {
  List<QuestionModel> questions;

  QuestionListModel({required this.questions});

  factory QuestionListModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> questionList = json['Questions'];
    List<QuestionModel> questions = questionList
        .map((questionJson) => QuestionModel.fromJson(questionJson))
        .toList();

    return QuestionListModel(questions: questions);
  }
}

class QuestionModel {
  String id;
  int answer;
  String explanation;
  String macroSubject;
  String microSubject;
  List<String> options;
  StatementModel statement;
  String year;

  QuestionModel({
    required this.id,
    required this.answer,
    required this.explanation,
    required this.macroSubject,
    required this.microSubject,
    required this.options,
    required this.statement,
    required this.year,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['_id'],
      answer: json['answer'],
      explanation: json['explanation'],
      macroSubject: json['macro_subject'],
      microSubject: json['micro_subject'],
      options: List<String>.from(json['options']),
      statement: StatementModel.fromJson(json['statement']),
      year: json['year'],
    );
  }
}

class StatementModel {
  String command;
  bool hasImg;
  String text;

  StatementModel({
    required this.command,
    required this.hasImg,
    required this.text,
  });

  factory StatementModel.fromJson(Map<String, dynamic> json) {
    return StatementModel(
      command: json['command'],
      hasImg: json['hasImg'],
      text: json['text'],
    );
  }

  
}
