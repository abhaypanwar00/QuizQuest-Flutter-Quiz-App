import 'package:flutter/material.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/constant/text.dart';
import 'package:quizz/src/functions/content/screens/quiz_configuration/quiz_configuration_dialog.dart';
import 'package:quizz/src/functions/content/widgets/coming_soon_dialog.dart';
import 'package:quizz/src/functions/content/widgets/topic_container.dart';

class CategoryOptions extends StatefulWidget {
  const CategoryOptions({
    super.key,
    required this.firstCategoryImage,
    required this.firstCategoryName,
    required this.secondCategoryImage,
    required this.secondCategoryName,
    required this.thirdCategoryImage,
    required this.thirdCategoryName,
    required this.category,
  });

  final String firstCategoryImage;
  final String firstCategoryName;
  final String secondCategoryImage;
  final String secondCategoryName;
  final String thirdCategoryImage;
  final String thirdCategoryName;
  final String category;

  @override
  CategoryOptionsState createState() => CategoryOptionsState();
}

class CategoryOptionsState extends State<CategoryOptions> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.42,
      left: 15,
      right: 15,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TopicContainer(
                    image: widget.firstCategoryImage,
                    topic: widget.firstCategoryName,
                    onTap: () {
                      quizConfigurationDialog(
                        context,
                        widget.firstCategoryName,
                        widget.category,
                      );
                    },
                  ),
                  TopicContainer(
                    image: widget.secondCategoryImage,
                    topic: widget.secondCategoryName,
                    onTap: () {
                      quizConfigurationDialog(
                        context,
                        widget.secondCategoryName,
                        widget.category,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TopicContainer(
                    image: widget.thirdCategoryImage,
                    topic: widget.thirdCategoryName,
                    onTap: () {
                      quizConfigurationDialog(
                        context,
                        widget.thirdCategoryName,
                        widget.category,
                      );
                    },
                  ),
                  TopicContainer(
                    image: soonImage,
                    topic: comingSoon,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ComingSoonDialog();
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
