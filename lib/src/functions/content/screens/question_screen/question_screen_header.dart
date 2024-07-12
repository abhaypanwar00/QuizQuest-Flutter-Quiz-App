import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz/src/constant/colors.dart';
import 'package:quizz/src/functions/content/screens/home_screen/home_screen.dart';
import 'package:quizz/src/functions/content/widgets/exit_dialog.dart';

class QuestionScreenHeader extends StatefulWidget {
  final int remainingSeconds;

  const QuestionScreenHeader({super.key, required this.remainingSeconds});

  @override
  QuestionScreenHeaderState createState() => QuestionScreenHeaderState();
}

class QuestionScreenHeaderState extends State<QuestionScreenHeader> {
  late Timer _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.remainingSeconds;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  String get timerText {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appPrimaryColor,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                color: Colors.transparent,
                border: Border.all(
                  color: appSecondaryColor,
                  width: 3,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    CupertinoIcons.stopwatch_fill,
                    color: appSecondaryColor,
                  ),
                  Text(
                    timerText,
                    style: const TextStyle(
                      color: appSecondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ExitDialog(
                      title: "Leave Quiz?",
                      content: "Do you want to leave this quiz?",
                      onYesTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: const Icon(
                Icons.exit_to_app_rounded,
                color: appSecondaryColor,
                size: 35,
              ),
            )
          ],
        ),
      ),
    );
  }
}
