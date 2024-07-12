import 'package:flutter/material.dart';
import 'package:quizz/src/constant/colors.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/functions/content/widgets/image_container.dart';
import 'package:quizz/src/functions/content/widgets/text_container.dart';
import 'package:quizz/src/functions/content/screens/question_screen/question_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
  });

  final List<QuizQuestion> questions;
  final List<String> selectedAnswers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.6,
              width: MediaQuery.of(context).size.width,
              child: const Stack(
                children: [
                  ImageContainer(image: details),
                  TextContainer(text: "Details"),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final selectedAnswer = index < selectedAnswers.length
                      ? selectedAnswers[index]
                      : "";
                  final isCorrect = selectedAnswer == question.correctAnswer;
                  final isUnanswered = selectedAnswer.isEmpty;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isUnanswered
                            ? Colors.orange.shade50
                            : isCorrect
                                ? Colors.green.shade50
                                : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          'Question ${index + 1}: ${question.question}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isUnanswered
                                  ? 'Not Answered'
                                  : 'Your Answer: $selectedAnswer',
                              style: TextStyle(
                                color: isUnanswered
                                    ? appPrimaryColor
                                    : isCorrect
                                        ? appSecondaryColor
                                        : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                              ),
                            ),
                            if (isUnanswered ||
                                (!isCorrect && selectedAnswer.isNotEmpty))
                              Text(
                                'Correct Answer: ${question.correctAnswer}',
                                style: TextStyle(
                                  color: appSecondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.035,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
