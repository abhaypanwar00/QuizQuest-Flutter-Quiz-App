import 'package:flutter/material.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/constant/text.dart';
import 'package:quizz/src/functions/authentication/screens/signIn/sign_in_form.dart';
import 'package:quizz/src/functions/authentication/screens/signUp/sign_up_screen.dart';
import 'package:quizz/src/functions/authentication/widgets/form/form_footer.dart';
import 'package:quizz/src/functions/authentication/widgets/form/form_header.dart';
import 'package:quizz/src/functions/authentication/widgets/form/loading.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
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
                      image: signInImage,
                      title: signInTitle,
                      subtitle: signInSubtitle,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: SignInForm(),
                    ),
                    FormFooter(
                      textSpan1: "Don't have an account? ",
                      textSpan2: "SignUp",
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
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
