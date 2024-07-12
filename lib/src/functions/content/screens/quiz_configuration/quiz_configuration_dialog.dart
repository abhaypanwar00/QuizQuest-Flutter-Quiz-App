import 'package:flutter/material.dart';
import 'package:quizz/src/constant/colors.dart';
import 'package:quizz/src/functions/content/screens/question_screen/question_screen.dart';
import 'package:quizz/src/functions/content/screens/quiz_configuration/batch_container.dart';

Future<Object?> quizConfigurationDialog(
  BuildContext context,
  String subCategory,
  String category,
) {
  String? selectedQuestionCountInDialog;
  String? selectedDifficultyInDialog;
  bool selectionsComplete = false;

  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "quiz",
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(
        begin: const Offset(0, -1),
        end: Offset.zero,
      );
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) {
      int categoryNumber = getCategoryNumber(subCategory.toLowerCase());
      return StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.46,
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 24,
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            subCategory,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.07,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        const Text(
                          "Select Number of Questions",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BatchContainer(
                              text: "5",
                              isSelected: selectedQuestionCountInDialog == "5",
                              onTap: () {
                                setState(() {
                                  selectedQuestionCountInDialog = "5";
                                  selectionsComplete =
                                      selectedQuestionCountInDialog != null &&
                                          selectedDifficultyInDialog != null;
                                });
                              },
                            ),
                            const SizedBox(width: 20),
                            BatchContainer(
                              text: "10",
                              isSelected: selectedQuestionCountInDialog == "10",
                              onTap: () {
                                setState(() {
                                  selectedQuestionCountInDialog = "10";
                                  selectionsComplete =
                                      selectedQuestionCountInDialog != null &&
                                          selectedDifficultyInDialog != null;
                                });
                              },
                            ),
                            const SizedBox(width: 20),
                            BatchContainer(
                              text: "15",
                              isSelected: selectedQuestionCountInDialog == "15",
                              onTap: () {
                                setState(() {
                                  selectedQuestionCountInDialog = "15";
                                  selectionsComplete =
                                      selectedQuestionCountInDialog != null &&
                                          selectedDifficultyInDialog != null;
                                });
                              },
                            ),
                            const SizedBox(width: 20),
                            BatchContainer(
                              text: "20",
                              isSelected: selectedQuestionCountInDialog == "20",
                              onTap: () {
                                setState(() {
                                  selectedQuestionCountInDialog = "20";
                                  selectionsComplete =
                                      selectedQuestionCountInDialog != null &&
                                          selectedDifficultyInDialog != null;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        const Text(
                          "Select Difficulty",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BatchContainer(
                              text: "Easy",
                              width: MediaQuery.of(context).size.width * 0.20,
                              isSelected: selectedDifficultyInDialog == "Easy",
                              onTap: () {
                                setState(() {
                                  selectedDifficultyInDialog = "Easy";
                                  selectionsComplete =
                                      selectedQuestionCountInDialog != null &&
                                          selectedDifficultyInDialog != null;
                                });
                              },
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            BatchContainer(
                              text: "Medium",
                              width: MediaQuery.of(context).size.width * 0.25,
                              isSelected:
                                  selectedDifficultyInDialog == "Medium",
                              onTap: () {
                                setState(() {
                                  selectedDifficultyInDialog = "Medium";
                                  selectionsComplete =
                                      selectedQuestionCountInDialog != null &&
                                          selectedDifficultyInDialog != null;
                                });
                              },
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            BatchContainer(
                              text: "Hard",
                              width: MediaQuery.of(context).size.width * 0.18,
                              isSelected: selectedDifficultyInDialog == "Hard",
                              onTap: () {
                                setState(() {
                                  selectedDifficultyInDialog = "Hard";
                                  selectionsComplete =
                                      selectedQuestionCountInDialog != null &&
                                          selectedDifficultyInDialog != null;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: selectionsComplete
                                  ? appSecondaryColor
                                  : appPrimaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              onTap: selectionsComplete
                                  ? () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => QuestionScreen(
                                            questionAmount:
                                                selectedQuestionCountInDialog,
                                            quizDifficulty:
                                                selectedDifficultyInDialog
                                                    ?.toLowerCase(),
                                            subCategoryNumber: categoryNumber,
                                            subCategory: subCategory,
                                            category: category,
                                          ),
                                        ),
                                      );
                                    }
                                  : null,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 200,
                                child: const Text(
                                  "Start Quiz",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.46,
                      left: 0,
                      right: 0,
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

int getCategoryNumber(String category) {
  switch (category) {
    case 'music':
      return 12;
    case 'books':
      return 10;
    case 'films':
      return 11;
    case 'computer':
      return 18;
    case 'maths':
      return 19;
    case 'science and nature':
      return 17;
    case 'geography':
      return 22;
    case 'history':
      return 23;
    case 'politics':
      return 24;
    case 'board games':
      return 16;
    case 'sports':
      return 21;
    case 'video games':
      return 15;
    case 'animals':
      return 27;
    case 'art':
      return 25;
    case 'mythology':
      return 20;
    default:
      return -1;
  }
}
