import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/constant/text.dart';
import 'package:quizz/src/functions/authentication/auth/auth_repository.dart';
import 'package:quizz/src/functions/content/screens/home_screen/home_screen.dart';
import 'package:quizz/src/widgets/outlined_button.dart';
import 'package:quizz/src/functions/authentication/widgets/buttons/text_button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late Timer _timer;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _startTimerForAutoRedirect();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        timer.cancel();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
  }

  void _resentLink() async {
    String? errorMessage = await _authService.sendEmailVerification();
    if (!mounted) return;
    if (errorMessage == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Verification email sent successfully.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: SvgPicture.asset(
                    verifyMail,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Email verification",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  verificationText1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  verificationText2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 50),
                OutlinedBtn(
                  text: "Continue",
                  onPressed: () {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null && user.emailVerified) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 50,
                ),
                const SizedBox(height: 50),
                TextBtn(
                  wantIcon: true,
                  color: Colors.blue,
                  text: "Resend E-Mail Link",
                  onPressed: _resentLink,
                  icon: Icons.repeat,
                ),
                const SizedBox(height: 10),
                TextBtn(
                  wantIcon: true,
                  color: Colors.blue,
                  icon: Icons.arrow_back,
                  text: "back to SignUp",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
