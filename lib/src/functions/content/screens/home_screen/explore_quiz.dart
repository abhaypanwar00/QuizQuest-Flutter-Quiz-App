import 'package:flutter/material.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/constant/text.dart';
import 'package:quizz/src/functions/content/screens/category_screen/category_screen.dart';
import 'package:quizz/src/functions/content/widgets/coming_soon_dialog.dart';
import 'package:quizz/src/functions/content/widgets/topic_container.dart';

class ExploreQuiz extends StatelessWidget {
  const ExploreQuiz({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(30),
              child: Row(
                children: [
                  Text(
                    "Explore Quizzes",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TopicContainer(
                  image: entertainmentImage,
                  topic: entertainment,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(
                          category: entertainment,
                          categoryImage: entertainmentImage,
                          categoryText: entertainment,
                          firstCategoryImage: musicImage,
                          firstCategoryName: music,
                          secondCategoryImage: filmsImage,
                          secondCategoryName: films,
                          thirdCategoryImage: booksImage,
                          thirdCategoryName: books,
                        ),
                      ),
                    );
                  },
                ),
                TopicContainer(
                  image: scienceImage,
                  topic: stem,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(
                          category: stem,
                          categoryImage: scienceImage,
                          categoryText: stem,
                          firstCategoryImage: computerImage,
                          firstCategoryName: computer,
                          secondCategoryImage: mathsImage,
                          secondCategoryName: maths,
                          thirdCategoryImage: scienceAndNatureImage,
                          thirdCategoryName: scienceAndNature,
                        ),
                      ),
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
                  image: socialImage,
                  topic: socialScience,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(
                          category: socialScience,
                          categoryImage: socialImage,
                          categoryText: socialScience,
                          firstCategoryImage: geographyImage,
                          firstCategoryName: geography,
                          secondCategoryImage: historyImage,
                          secondCategoryName: history,
                          thirdCategoryImage: politicsImage,
                          thirdCategoryName: politics,
                        ),
                      ),
                    );
                  },
                ),
                TopicContainer(
                  image: gamesImage,
                  topic: games,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(
                          category: games,
                          categoryImage: gamesImage,
                          categoryText: games,
                          firstCategoryImage: boardGamesImage,
                          firstCategoryName: boardGames,
                          secondCategoryImage: sportsImage,
                          secondCategoryName: sports,
                          thirdCategoryImage: videoGamesImage,
                          thirdCategoryName: videoGames,
                        ),
                      ),
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
                  image: assortmentImage,
                  topic: assortment,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(
                          category: assortment,
                          categoryImage: assortmentImage,
                          categoryText: assortment,
                          firstCategoryImage: animalsImage,
                          firstCategoryName: animals,
                          secondCategoryImage: artImage,
                          secondCategoryName: art,
                          thirdCategoryImage: gkImage,
                          thirdCategoryName: mythology,
                        ),
                      ),
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
                        });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
