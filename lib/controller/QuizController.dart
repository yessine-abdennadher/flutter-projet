import 'package:flutter/material.dart';
import 'package:my_library/models/question.dart';

class QuizController with ChangeNotifier {
  List<Question> questions = [];
  int currentIndex = 0;
  int score = 0;
  String? selectedAnswer;
  bool isAnswered = false;

  // Méthode pour charger les questions
  void loadQuestions(List<Question> loadedQuestions) {
    questions = loadedQuestions;
    notifyListeners();  // Notifie les listeners (widgets) lorsque les questions sont chargées
  }

  // Vérifier si la réponse est correcte
  void checkAnswer(String answer) {
    if (isAnswered) return;  // Empêche de répondre plusieurs fois

    selectedAnswer = answer;
    isAnswered = true;

    if (answer == questions[currentIndex].correctAnswer) {
      score++;
    }

    notifyListeners();  // Notifie pour mettre à jour l'UI

    // Passer à la question suivante après un délai
    Future.delayed(const Duration(seconds: 1), () {
      if (currentIndex < questions.length - 1) {
        currentIndex++;
        selectedAnswer = null;
        isAnswered = false;
        notifyListeners();
      } else {
        // Logique à ajouter pour afficher le résultat une fois toutes les questions terminées
      }
    });
  }

  // Réinitialiser le quiz
  void resetQuiz() {
    currentIndex = 0;
    score = 0;
    selectedAnswer = null;
    isAnswered = false;
    notifyListeners();
  }
}
