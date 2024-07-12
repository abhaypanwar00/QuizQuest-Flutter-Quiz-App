import 'package:flutter/material.dart';
import 'package:quizz/src/constant/images.dart';
import 'package:quizz/src/constant/text.dart';
import 'package:quizz/src/functions/authentication/auth/auth_repository.dart';
import 'package:quizz/src/widgets/elevated_button.dart';
import 'package:quizz/src/functions/authentication/widgets/buttons/text_button.dart';
import 'package:quizz/src/functions/authentication/widgets/form/form_header.dart';
import 'package:quizz/src/functions/authentication/widgets/form/text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  late FocusNode _emailFocusNode;

  final AuthService _authService = AuthService();

  void _resetPassword() async {
    String? errorMessage =
        await _authService.resetPassword(_emailController.text);
    if (!mounted) return;
    if (errorMessage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent successfully.'),
        ),
      );
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
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FormHeader(
                  image: forgotPasswordImage,
                  title: forgotPasswordTitle,
                  subtitle: forgotPasswordSubtitle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: TextForm(
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    labelText: "Email",
                    prefixIcon: Icons.email,
                    obscureText: false,
                  ),
                ),
                ElevatedBtn(
                  text: "RESET",
                  onPressed: _resetPassword,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                ),
                const SizedBox(height: 50),
                TextBtn(
                  wantIcon: true,
                  icon: Icons.arrow_back,
                  text: "back to SignIn",
                  color: Colors.blue,
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
