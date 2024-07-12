import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizz/src/constant/colors.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/functions/authentication/auth/auth_repository.dart';
import 'package:quizz/src/functions/authentication/screens/welcome/welcome_screen.dart';
import 'package:quizz/src/functions/content/screens/home_screen/explore_quiz.dart';
import 'package:quizz/src/functions/content/screens/home_screen/home_screen_header.dart';
import 'package:quizz/src/functions/content/screens/drawer/leaderboard_screen.dart';
import 'package:quizz/src/functions/content/screens/drawer/stats_screen.dart';
import 'package:quizz/src/functions/content/widgets/exit_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<dynamic> user;

  @override
  void initState() {
    user = AuthService().getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      drawer: DrawerWidget(
        user: user,
      ),
      body: const Column(
        children: [
          HomeScreenHeader(),
          Expanded(
            child: ExploreQuiz(),
          )
        ],
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.user,
  });

  final Future<dynamic> user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green.shade50,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data == null) {
                  return const Text(
                    "Hey,\nGuest",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                }
                Map<String, dynamic> userData =
                    snapshot.data!.data() as Map<String, dynamic>;
                String name = userData['name'];
                String email = userData['email'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: appPrimaryColor,
                      child: ClipOval(
                        child: SvgPicture.asset(profile),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.graph_square,
              color: appSecondaryColor,
              size: 30,
            ),
            title: const Text(
              'Statistics',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StatisticsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.chart_bar_square,
              color: appSecondaryColor,
              size: 30,
            ),
            title: const Text(
              'Leaderboard',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LeaderboardScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: appSecondaryColor,
              size: 30,
            ),
            title: const Text(
              'SignOut',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ExitDialog(
                    title: "SignOut",
                    content: "Do you want to sign out from the QuizQuest!",
                    onYesTap: () {
                      AuthService().signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
