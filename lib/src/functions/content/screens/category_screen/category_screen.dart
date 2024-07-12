import 'package:flutter/material.dart';
import 'package:quizz/src/functions/content/screens/category_screen/category_options.dart';
import 'package:quizz/src/functions/content/widgets/image_container.dart';
import 'package:quizz/src/functions/content/widgets/text_container.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.categoryImage,
    required this.categoryText,
    required this.firstCategoryImage,
    required this.firstCategoryName,
    required this.secondCategoryImage,
    required this.secondCategoryName,
    required this.thirdCategoryImage,
    required this.thirdCategoryName,
    required this.category,
  });

  final String categoryImage, categoryText;
  final String firstCategoryImage, firstCategoryName;
  final String secondCategoryImage, secondCategoryName;
  final String thirdCategoryImage, thirdCategoryName;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: SafeArea(
        child: Stack(
          children: [
            ImageContainer(image: categoryImage),
            TextContainer(text: categoryText),
            CategoryOptions(
              firstCategoryImage: firstCategoryImage,
              firstCategoryName: firstCategoryName,
              secondCategoryImage: secondCategoryImage,
              secondCategoryName: secondCategoryName,
              thirdCategoryImage: thirdCategoryImage,
              thirdCategoryName: thirdCategoryName,
              category: category,
            )
          ],
        ),
      ),
    );
  }
}
