import 'package:flutter/material.dart';
import 'package:quizz/src/functions/authentication/screens/signIn/sign_in_screen.dart';
import 'package:quizz/src/functions/authentication/screens/signUp/sign_up_screen.dart';
import 'package:quizz/src/widgets/elevated_button.dart';
import 'package:quizz/src/widgets/outlined_button.dart';

class AccessButtons extends StatelessWidget {
  const AccessButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedBtn(
          text: "SIGN IN",
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
            );
          },
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
        ),
        const SizedBox(height: 20),
        ElevatedBtn(
          text: "SIGN UP",
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          },
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
        ),
      ],
    );
  }
}
