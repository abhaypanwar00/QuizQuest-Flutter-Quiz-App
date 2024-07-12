import 'package:flutter/material.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/functions/content/screens/drawer/leaderboard_screen.dart';
import 'package:quizz/src/widgets/elevated_button.dart';
import 'package:quizz/src/functions/content/screens/home_screen/home_screen.dart';
import 'package:quizz/src/functions/content/screens/question_screen/question_screen.dart';
import 'package:quizz/src/functions/content/screens/result_screen/details_screen.dart';
import 'package:quizz/src/functions/content/screens/result_screen/result_image_container.dart';
import 'package:quizz/src/functions/content/screens/result_screen/result_text_container.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.questions,
    required this.selectedAnswers,
    required this.notAnswered,
    required this.wrongAnswers,
  });

  final int totalQuestions;
  final int correctAnswers;
  final int notAnswered;
  final int wrongAnswers;
  final List<QuizQuestion> questions;
  final List<String> selectedAnswers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: SafeArea(
        child: Stack(
          children: [
            const ResultImageContainer(image: result),
            ResultTextContainer(
              totalQuestions: totalQuestions,
              correctAnswers: correctAnswers,
              selectedAnswers: selectedAnswers,
              notAnswered: notAnswered,
              wrongAnswers: wrongAnswers,
            ),
            Positioned(
              bottom: 30,
              left: 30,
              right: 30,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedBtn(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  questions: questions,
                                  selectedAnswers: selectedAnswers,
                                ),
                              ),
                            );
                          },
                          text: "Details",
                          width: 100,
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedBtn(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          text: "Home",
                          width: 100,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedBtn(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    text: "Leaderboard",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LeaderboardScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
