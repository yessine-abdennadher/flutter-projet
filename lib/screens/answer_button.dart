import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isAnswered;
  final VoidCallback onTap;

  const AnswerButton({
    Key? key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isAnswered,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.purple;
    Color? bgColor;
    IconData? icon;

    if (isAnswered) {
      if (isSelected && isCorrect) {
        bgColor = Colors.green[50];
        icon = Icons.check_circle;
        borderColor = Colors.green;
      } else if (isSelected && !isCorrect) {
        bgColor = Colors.red[50];
        icon = Icons.cancel;
        borderColor = Colors.red;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: OutlinedButton(
        onPressed: isAnswered ? null : onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          backgroundColor: bgColor ?? Colors.white,
          side: BorderSide(color: borderColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.purple[800],
                ),
              ),
            ),
            if (icon != null)
              Icon(
                icon,
                color: icon == Icons.check_circle ? Colors.green : Colors.red,
              )
          ],
        ),
      ),
    );
  }
}
