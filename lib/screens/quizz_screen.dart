import 'package:flutter/material.dart';
import 'package:my_library/models/categorie.dart';

import 'package:my_library/screens/quiz_cong.dart'; //
// quiz_conf.dart contient le widget QuizConf

class QuizzScreen extends StatefulWidget {
  final Categorie categories;

  const QuizzScreen({Key? key, required this.categories}) : super(key: key);

  @override
  State<QuizzScreen> createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  String selectedDifficulty = "easy";
  bool hasTimer = true;
  bool soundEffects = true;
  bool backgroundMusic = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Paramètres du Quiz"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Choisissez vos options",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 30),

                const Text(
                  "Niveau de difficulté",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ["Facile", "Moyen", "Difficile"].map((label) {
                    final Map<String, String> difficultyMap = {
                      "Facile": "easy",
                      "Moyen": "medium",
                      "Difficile": "hard",
                    };
                    final String value = difficultyMap[label]!;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedDifficulty == value
                                ? Colors.purple[400]
                                : Colors.white,
                            foregroundColor: selectedDifficulty == value
                                ? Colors.white
                                : Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: selectedDifficulty == value
                                    ? Colors.purple!
                                    : Colors.grey.shade300,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            elevation: selectedDifficulty == value ? 4 : 0,
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedDifficulty = value;
                            });
                          },
                          child: Text(label),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 30),

                _buildSettingItem(
                  icon: Icons.timer,
                  text: "Activer la minuterie",
                  value: hasTimer,
                  onChanged: (val) => setState(() => hasTimer = val),
                ),
                const SizedBox(height: 16),

                _buildSettingItem(
                  icon: Icons.surround_sound,
                  text: "Effets sonores",
                  value: soundEffects,
                  onChanged: (val) => setState(() => soundEffects = val),
                ),
                const SizedBox(height: 16),

                _buildSettingItem(
                  icon: Icons.music_note,
                  text: "Musique de fond",
                  value: backgroundMusic,
                  onChanged: (val) => setState(() => backgroundMusic = val),
                ),

                const Spacer(),

                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizConf(
                            hasTimer: hasTimer,
                            difficulty: selectedDifficulty,
                            backgroundMusic: backgroundMusic,
                            soundEffects: soundEffects,
                            categoryId: widget.categories.id,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Commencer",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String text,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.purple, size: 28),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 16)),
          ],
        ),
        Switch(
          value: value,
          activeColor: Colors.purple,
          inactiveTrackColor: Colors.grey[300],
          onChanged: onChanged,
        ),
      ],
    );
  }
}
