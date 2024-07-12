import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quizz/src/constant/colors.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/functions/content/firebase/database_service.dart';
import 'package:quizz/src/functions/content/widgets/image_container.dart';
import 'package:quizz/src/functions/content/widgets/text_container.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<bool> isGrowth = [];
  List<bool> isNew = [];
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.38,
              width: MediaQuery.of(context).size.width,
              child: const Stack(
                children: [
                  ImageContainer(image: leaderboard),
                  TextContainer(text: "Leaderboard"),
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: DatabaseService().fetchLeaderboard(),
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
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No leaderboard data available.'),
                  );
                }

                final leaderboard = snapshot.data!;

                return ListView.builder(
                  itemCount: leaderboard.length,
                  itemBuilder: (context, index) {
                    final user = leaderboard[index];
                    final userId = user['uid'];
                    final previousScore = user['previousScore'];
                    final presentScore = user['presentScore'];
                    final leaderboardScore = user['leaderboardScore'];

                    if (isGrowth.length != leaderboard.length &&
                        isNew.length != leaderboard.length) {
                      isGrowth = List.filled(leaderboard.length, false);
                      isNew = List.filled(leaderboard.length, false);
                    }

                    if (presentScore > previousScore) {
                      isGrowth[index] = true;
                    } else if (presentScore == 0 &&
                        previousScore == 0 &&
                        leaderboardScore == 0) {
                      isNew[index] = true;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isNew[index]
                              ? Colors.orange.shade50
                              : isGrowth[index]
                                  ? Colors.green.shade50
                                  : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: userId == currentUserId
                              ? Border.all(
                                  color: isNew[index]
                                      ? appPrimaryColor
                                      : isGrowth[index]
                                          ? appSecondaryColor
                                          : Colors.red,
                                  width: 3,
                                )
                              : null,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Text(
                                "${index + 1}.",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              title: Text(
                                "${user['name']}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(
                                "Score: ${user['leaderboardScore']} pts",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              ),
                              trailing: Icon(
                                isNew[index]
                                    ? null
                                    : isGrowth[index]
                                        ? CupertinoIcons.arrowtriangle_up_fill
                                        : CupertinoIcons
                                            .arrowtriangle_down_fill,
                                color: isNew[index]
                                    ? null
                                    : isGrowth[index]
                                        ? appSecondaryColor
                                        : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
