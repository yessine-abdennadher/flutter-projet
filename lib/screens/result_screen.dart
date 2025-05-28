import 'package:flutter/material.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({Key? key, required this.score, required this.total})
      : super(key: key);

  // Méthode pour générer un commentaire en fonction du score
  String getComment() {
    double percentage = (score / total) * 100;

    if (percentage >= 90) {
      return "Excellent travail ! 🌟 Tu maîtrises parfaitement le sujet !";
    } else if (percentage >= 75) {
      return "Très bon résultat ! 😊 Continue comme ça !";
    } else if (percentage >= 50) {
      return "Bon effort ! 👍 Mais il reste encore des choses à réviser.";
    } else {
      return "Tu peux faire mieux ! 💪 Ne te laisse pas décourager !";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Résultats"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 🖼️ Fond : IMAGE QUI COUVRE TOUT L'ÉCRAN
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(

              ),
              image: const DecorationImage(
                image: AssetImage('assets/images/bg9.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 📇 Carte blanche stylisée
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 520,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 120),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 3,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.purple,
                    size: 60,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Tu as obtenu :",
                    style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$score / $total",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 📝 Commentaire dynamique
                  Text(
                    getComment(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Bouton Rejouer
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) =>  Home()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "Rejouer",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}