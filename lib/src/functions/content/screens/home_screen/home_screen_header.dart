import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quizz/src/constant/colors.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/functions/authentication/auth/auth_repository.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      color: appPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: SvgPicture.asset(
                    menu,
                    height: 25,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 5.3),
                const Text(
                  "QuizQuest!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: auth.getUserInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.hasError ||
                              !snapshot.hasData ||
                              snapshot.data == null) {
                            return Column(
                              children: [
                                Text(
                                  "Hey,",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                  ),
                                ),
                                LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: 40,
                                )
                              ],
                            );
                          }
                          Map<String, dynamic> userData =
                              snapshot.data!.data() as Map<String, dynamic>;
                          String name = userData['name'];
                          return Text(
                            "Hey,\n$name",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                          );
                        }),
                    const SizedBox(height: 10),
                    Text(
                      "Challenge yourself\nwith fun trivia questions.",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                      ),
                    )
                  ],
                ),
              ),
              SvgPicture.asset(
                quizImage,
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.17,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
