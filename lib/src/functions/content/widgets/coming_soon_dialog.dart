import 'package:flutter/material.dart';
import 'package:quizz/src/constant/colors.dart';

class ComingSoonDialog extends StatelessWidget {
  const ComingSoonDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green.shade50,
      title: const Text(
        "Coming Soon!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "More exciting quizzes are coming soon!",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: MediaQuery.of(context).size.width * 0.04,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "OK",
            style: TextStyle(
              color: appSecondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.04,
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
