import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';
import 'package:quizz/src/constant/colors.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/functions/content/firebase/database_service.dart';
import 'package:quizz/src/functions/content/widgets/image_container.dart';
import 'package:quizz/src/functions/content/widgets/text_container.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  StatisticsScreenState createState() => StatisticsScreenState();
}

class StatisticsScreenState extends State<StatisticsScreen> {
  late Future<List<QuizResult>> _quizResults;
  List<bool> _expandedState = [];
  List<QuizResult> _sortedResults = [];
  String _selectedSort = 'Date';

  @override
  void initState() {
    super.initState();
    _fetchAndSortResults();
  }

  void _fetchAndSortResults() {
    _quizResults = DatabaseService().fetchQuizResults();
    _quizResults.then((results) {
      _sortResults(results);
    });
  }

  void _sortResults(List<QuizResult> results) {
    setState(() {
      _sortedResults = List.from(results);
      switch (_selectedSort) {
        case 'Date':
          _sortedResults.sort((a, b) => b.date.compareTo(a.date));
          break;
        case 'Score':
          _sortedResults.sort((a, b) => b.score.compareTo(a.score));
          break;
        case 'Difficulty':
          _sortedResults.sort((a, b) => a.difficulty.compareTo(b.difficulty));
          break;
        case 'Category':
          _sortedResults.sort((a, b) => a.category.compareTo(b.category));
          break;
      }
      _expandedState = List.filled(_sortedResults.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.38,
              width: MediaQuery.of(context).size.width,
              child: const Stack(
                children: [
                  ImageContainer(image: stats),
                  TextContainer(text: "Statistics"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _sortDropdown(),
                  Text(
                    textAlign: TextAlign.center,
                    "Total Quiz: ${_sortedResults.length}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<QuizResult>>(
                future: _quizResults,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.dotsTriangle(
                        color: appSecondaryColor,
                        size: 50,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No quiz results available.'));
                  }

                  return _quizResultsList();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _sortDropdown() {
    return DropdownButton<String>(
      value: _selectedSort,
      onChanged: (String? newValue) {
        setState(() {
          _selectedSort = newValue!;
          _sortResults(_sortedResults);
        });
      },
      items: <String>['Date', 'Score', 'Difficulty', 'Category']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text("Sort By $value"),
        );
      }).toList(),
      dropdownColor: Colors.white,
      elevation: 0,
      underline: const SizedBox(),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
    );
  }

  Widget _quizResultsList() {
    return ListView.builder(
      itemCount: _sortedResults.length,
      itemBuilder: (context, index) {
        final result = _sortedResults[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "Category: ${result.category}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      setState(() {
                        _expandedState[index] = !_expandedState[index];
                      });
                    },
                    child: Icon(
                      _expandedState[index]
                          ? CupertinoIcons.chevron_up
                          : CupertinoIcons.chevron_down,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sub-Category: ${result.subCategory}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_selectedSort == 'Date')
                        Text(
                          "Date: ${DateFormat.yMMMd().format(result.date)}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
                if (_expandedState[index])
                  Padding(
                    padding: const EdgeInsets.only(left: 18, bottom: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _resultDetail('Difficulty', result.difficulty),
                          _resultDetail(
                              'Total Questions', result.totalQuestions),
                          _resultDetail(
                              'Correct Answers', result.correctAnswers),
                          _resultDetail('Wrong Answers', result.wrongAnswers),
                          _resultDetail(
                              'Not Answered',
                              result.totalQuestions -
                                  (result.correctAnswers +
                                      result.wrongAnswers)),
                          _resultDetail('Score', result.score),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _resultDetail(String label, dynamic value) {
    return Text(
      '$label: $value',
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
    );
  }
}
