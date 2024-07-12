import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizz/src/constant/colors.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/constant/text.dart';
import 'package:quizz/src/functions/authentication/screens/welcome/access_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              welcomeImage,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Column(
              children: [
                Text(
                  welcomeTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.065,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  welcomeSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: MediaQuery.of(context).size.width * 0.037,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            const AccessButtons()
          ],
        ),
      ),
    );
  }
}
