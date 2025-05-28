import 'package:html_unescape/html_unescape.dart';

class Question {
  final String question;
  final List<String> answers;
  final String correctAnswer;

  Question({
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final unescape = HtmlUnescape();

    List<String> allAnswers = (json["incorrect_answers"] as List)
        .map((answer) => unescape.convert(answer.toString()))
        .toList();

    String correct = unescape.convert(json["correct_answer"]);
    allAnswers.add(correct);
    allAnswers.shuffle();

    return Question(
      question: unescape.convert(json["question"]),
      answers: allAnswers,
      correctAnswer: correct,
    );
  }
}
