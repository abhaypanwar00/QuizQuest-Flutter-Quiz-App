import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quizz/src/constant/colors.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/functions/authentication/auth/auth_repository.dart';
import 'package:quizz/src/functions/content/screens/home_screen/home_screen.dart';

class FormFooter extends StatefulWidget {
  const FormFooter({
    super.key,
    required this.textSpan1,
    required this.textSpan2,
    required this.onPressed,
    required this.setLoading,
  });

  final String textSpan1;
  final String textSpan2;
  final VoidCallback onPressed;
  final Function(bool) setLoading;

  @override
  State<FormFooter> createState() => _FormFooterState();
}

class _FormFooterState extends State<FormFooter> {
  final AuthService authService = AuthService();

  void _googleSignIn() async {
    widget.setLoading(true);

    String? errorMessage = await authService.signInWithGoogle();

    if (!mounted) return;

    widget.setLoading(false);

    if (errorMessage == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      log(errorMessage);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Or Continue With",
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.black26,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _googleSignIn,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: appPrimaryColor,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                googleImage,
                height: 25,
                width: 25,
              ),
              const SizedBox(width: 10),
              Text(
                "Google",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: widget.onPressed,
          child: Text.rich(
            TextSpan(
              text: widget.textSpan1,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              children: [
                TextSpan(
                  text: widget.textSpan2,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
