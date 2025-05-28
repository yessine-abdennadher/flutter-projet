import 'package:flutter/material.dart';
class QuestionCard extends StatelessWidget {
  final String questionText;
  final int remainingTime;

  const QuestionCard({
    Key? key,
    required this.questionText,
    required this.remainingTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.pinkAccent,
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              children: [
                Text(
                  questionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(52, 41, 69, 0.92),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.pinkAccent,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$remainingTime',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

