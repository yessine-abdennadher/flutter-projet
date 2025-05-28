import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_library/models/question.dart';


class ApiQuiz {
  static Future<List<Question>> fetchQuestions(String difficulty, int categoryId) async {
    final String apiQuizzUrl =
        "https://opentdb.com/api.php?amount=10&category=$categoryId&difficulty=$difficulty&type=multiple";

    final response = await http.get(Uri.parse(apiQuizzUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data["results"] as List)
          .map((q) => Question.fromJson(q))
          .toList();
    } else {
      return [];
    }
  }
}


