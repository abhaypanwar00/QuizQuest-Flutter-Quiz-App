import 'package:flutter/material.dart';
import 'package:quizz/src/constant/colors.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onYesTap,
  });

  final String title;
  final String content;
  final VoidCallback onYesTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green.shade50,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onYesTap,
          child: const Text(
            "YES",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          child: const Text(
            "NO",
            style: TextStyle(
              color: appSecondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
