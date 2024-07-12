import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quizz/src/constant/colors.dart';
import 'package:quizz/src/functions/content/firebase/database_service.dart';
import 'package:quizz/src/widgets/elevated_button.dart';
import 'package:quizz/src/functions/content/screens/question_screen/option_container.dart';
import 'package:quizz/src/functions/content/screens/question_screen/question_screen_header.dart';
import 'package:quizz/src/functions/content/screens/result_screen/result_screen.dart';
import 'package:quizz/src/widgets/outlined_button.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    var unescape = HtmlUnescape();
    List<String> options = List<String>.from(json['incorrect_answers']);
    String correctAnswer = json['correct_answer'];
    options.add(correctAnswer);
    options.shuffle();

    return QuizQuestion(
      question: unescape.convert(json['question']),
      options: options.map((option) => unescape.convert(option)).toList(),
      correctAnswer: unescape.convert(correctAnswer),
    );
  }
}

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    super.key,
    required this.questionAmount,
    required this.quizDifficulty,
    required this.subCategoryNumber,
    required this.subCategory,
    required this.category,
  });

  final String? questionAmount;
  final String? quizDifficulty;
  final int subCategoryNumber;
  final String subCategory;
  final String category;

  @override
  QuestionScreenState createState() => QuestionScreenState();
}

class QuestionScreenState extends State<QuestionScreen> {
  late Future<QuizQuestion> _futureQuestion;
  late Timer _timer;
  late int _remainingSeconds;

  List<QuizQuestion> _questionCache = [];
  List<String> _selectedAnswers = [];

  int _cacheIndex = 0;
  int _selectedOption = -1;
  int _questionNumber = 1;
  int _correctAnswers = 0;
  int notAnswered = 0;
  int wrongAnswers = 0;

  bool _isLoadingNextQuestion = false;

  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    int questionCount = int.parse(widget.questionAmount!);
    _remainingSeconds = (questionCount * 60) ~/ 2;
    _futureQuestion = fetchAndCacheQuestions();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
        _finishQuiz();
      }
    });
  }

  Future<void> fetchQuestions() async {
    String? questionAmount = widget.questionAmount;
    String? questionDifficulty = widget.quizDifficulty;
    int questionCategory = widget.subCategoryNumber;
    const int maxReTries = 3;
    int delay = 1000;
    int attempt = 0;

    while (attempt < maxReTries) {
      try {
        final response = await http.get(
          Uri.parse(
            'https://opentdb.com/api.php?amount=$questionAmount&category=$questionCategory&difficulty=$questionDifficulty&type=multiple',
          ),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['results'] != null && data['results'].isNotEmpty) {
            _questionCache = data['results']
                .map<QuizQuestion>((json) => QuizQuestion.fromJson(json))
                .toList();
            _selectedAnswers = List<String>.filled(_questionCache.length, "");
            return;
          } else {
            throw Exception('No questions found in the API response');
          }
        } else if (response.statusCode == 429) {
          // Too many requests, wait and retry
          await Future.delayed(Duration(milliseconds: delay));
          delay *= 2; // Exponential backoff
          attempt++;
        } else {
          throw Exception('Failed to load questions: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Failed to load questions');
      }
    }
    throw Exception('Failed to load questions');
  }

  Future<QuizQuestion> fetchAndCacheQuestions() async {
    await fetchQuestions();
    return _questionCache[_cacheIndex];
  }

  void _onOptionTap(int index) {
    setState(() {
      _selectedOption = index;
      _selectedAnswers[_cacheIndex] =
          _questionCache[_cacheIndex].options[index];
    });
  }

  void _onClearChoice() {
    setState(() {
      _selectedOption = -1;
      _selectedAnswers[_cacheIndex] = "";
    });
  }

  void _loadNextQuestion() async {
    setState(() {
      _isLoadingNextQuestion = true;
    });

    if (_cacheIndex < _questionCache.length - 1) {
      setState(() {
        _cacheIndex++;
        _futureQuestion = Future.value(_questionCache[_cacheIndex]);
        _selectedOption = _questionCache[_cacheIndex]
            .options
            .indexOf(_selectedAnswers[_cacheIndex]);
        _questionNumber++;
        _isLoadingNextQuestion = false;
      });
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    for (int i = 0; i < _questionCache.length; i++) {
      if (_selectedAnswers[i].isEmpty) {
        notAnswered++;
      } else if (_selectedAnswers[i] == _questionCache[i].correctAnswer) {
        _correctAnswers++;
      } else {
        wrongAnswers++;
      }
    }

    _databaseService.saveQuizResult(
      QuizResult(
        date: DateTime.now(),
        category: widget.category,
        subCategory: widget.subCategory,
        difficulty: widget.quizDifficulty.toString(),
        correctAnswers: _correctAnswers,
        totalQuestions: int.parse(widget.questionAmount!),
        wrongAnswers: wrongAnswers,
        score: calculateScore(),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          totalQuestions: int.parse(widget.questionAmount!),
          correctAnswers: _correctAnswers,
          notAnswered: notAnswered,
          questions: _questionCache,
          selectedAnswers: _selectedAnswers,
          wrongAnswers: wrongAnswers,
        ),
      ),
    );
  }

  int calculateScore() {
    int score = 0;
    if (widget.quizDifficulty == 'easy') {
      score = (_correctAnswers * 2) - (wrongAnswers * 1);
    } else if (widget.quizDifficulty == 'medium') {
      score = (_correctAnswers * 4) - (wrongAnswers * 2);
    } else if (widget.quizDifficulty == 'hard') {
      score = (_correctAnswers * 6) - (wrongAnswers * 3);
    }
    return score;
  }

  void _loadPreviousQuestion() {
    if (_questionNumber == 1) return;

    setState(() {
      if (_cacheIndex > 0) {
        _cacheIndex--;
        _futureQuestion = Future.value(_questionCache[_cacheIndex]);
        _selectedOption = _questionCache[_cacheIndex]
            .options
            .indexOf(_selectedAnswers[_cacheIndex]);
        _questionNumber--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            QuestionScreenHeader(remainingSeconds: _remainingSeconds),
            Expanded(
              child: FutureBuilder<QuizQuestion>(
                future: _futureQuestion,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.dotsTriangle(
                        color: appSecondaryColor,
                        size: 50,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final question = snapshot.data!;
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Question $_questionNumber",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              question.question,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ...List.generate(
                              question.options.length,
                              (index) => SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: OptionContainer(
                                    index: index,
                                    isSelected: _selectedOption == index,
                                    onTap: () => _onOptionTap(index),
                                    optionText: question.options[index],
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            OutlinedBtn(
                              onPressed: _onClearChoice,
                              text: "Clear My Choice",
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.width * 0.11,
                              borderColor: Colors.red,
                              backgroundColor: Colors.red.shade50,
                              foregroundColor: Colors.red,
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: Text('No data'));
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  if (_questionNumber > 1)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ElevatedBtn(
                        isIcon: true,
                        icon: CupertinoIcons.back,
                        onPressed: _isLoadingNextQuestion
                            ? null
                            : _loadPreviousQuestion,
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.width * 0.13,
                      ),
                    ),
                  Expanded(
                    child: ElevatedBtn(
                      text: _questionNumber == int.parse(widget.questionAmount!)
                          ? 'FINISH'
                          : 'NEXT',
                      onPressed:
                          _isLoadingNextQuestion ? null : _loadNextQuestion,
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.width * 0.13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
