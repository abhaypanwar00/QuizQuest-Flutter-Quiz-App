import 'package:flutter/material.dart';
import 'package:quizz/src/constant/colors.dart';

class ResultTextContainer extends StatelessWidget {
  const ResultTextContainer({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.selectedAnswers,
    required this.notAnswered,
    required this.wrongAnswers,
  });

  final int totalQuestions;
  final int correctAnswers;
  final int notAnswered;
  final int wrongAnswers;
  final List<String> selectedAnswers;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.27,
      left: 35,
      right: 35,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: const BoxDecoration(
          color: appSecondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ResultRow(
                  text1: "$totalQuestions",
                  text2: "Total Questions",
                ),
                ResultRow(
                  text1: "$notAnswered",
                  text2: "Not Answered",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ResultRow(
                  text1: "$correctAnswers",
                  text2: "Correct Answers",
                ),
                ResultRow(
                  text1: "$wrongAnswers",
                  text2: "Wrong Answers",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResultRow extends StatelessWidget {
  const ResultRow({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.37,
      color: appSecondaryColor,
      child: Padding(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Icon(
                Icons.circle,
                size: MediaQuery.of(context).size.width * 0.03,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      text1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  text2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.037,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
