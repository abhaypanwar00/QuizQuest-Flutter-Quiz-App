import 'package:flutter/material.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/constant/text.dart';
import 'package:quizz/src/functions/authentication/screens/signIn/sign_in_screen.dart';
import 'package:quizz/src/functions/authentication/screens/signUp/sign_up_form.dart';
import 'package:quizz/src/functions/authentication/widgets/form/form_footer.dart';
import 'package:quizz/src/functions/authentication/widgets/form/form_header.dart';
import 'package:quizz/src/functions/authentication/widgets/form/loading.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;

  void _setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FormHeader(
                      image: signUpImage,
                      title: signUpTitle,
                      subtitle: signUpSubtitle,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: SignUpForm(),
                    ),
                    FormFooter(
                      textSpan1: "Already have an account? ",
                      textSpan2: "SignIn",
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      },
                      setLoading: _setLoading,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading) const LoadingOverlay(),
        ],
      ),
    );
  }
}
