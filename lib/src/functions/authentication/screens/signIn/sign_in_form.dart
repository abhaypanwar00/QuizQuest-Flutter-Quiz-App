import 'package:flutter/material.dart';
import 'package:quizz/src/functions/authentication/auth/auth_repository.dart';
import 'package:quizz/src/functions/authentication/screens/signIn/forgot_password_screen.dart';
import 'package:quizz/src/functions/content/screens/home_screen/home_screen.dart';
import 'package:quizz/src/widgets/elevated_button.dart';
import 'package:quizz/src/functions/authentication/widgets/buttons/text_button.dart';
import 'package:quizz/src/functions/authentication/widgets/form/text_form_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  final AuthService _authService = AuthService();

  bool _isLoading = false;

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextForm(
            focusNode: _emailFocusNode,
            controller: _emailController,
            labelText: "Email",
            validator: (value) {
              if (value == null || value.isEmpty) {
                _errorMessage = 'Please enter all credentials';
              }
              return null;
            },
            prefixIcon: Icons.person,
            obscureText: false,
            onChanged: (_) => _clearErrorMessage(),
          ),
          const SizedBox(height: 15),
          TextForm(
            focusNode: _passwordFocusNode,
            controller: _passwordController,
            labelText: "Password",
            validator: (value) {
              if (value == null || value.isEmpty) {
                _errorMessage = 'Please enter all credentials';
              }
              return null;
            },
            prefixIcon: Icons.lock,
            obscureText: true,
            suffixIcon: Icons.remove_red_eye_rounded,
            onChanged: (_) => _clearErrorMessage(),
          ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topRight,
            child: TextBtn(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ),
                );
              },
              wantIcon: false,
              text: "Forgot Password?",
              fontSize: 15,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedBtn(
            text: "SIGN IN",
            onPressed: _submitForm,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            loading: _isLoading,
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      setState(() {
        _isLoading = true;
      });

      _signIn(email, password);

      FocusScope.of(context).unfocus();
    }
  }

  void _signIn(String email, String password) async {
    String? errorMessage = await _authService.signInWithEmailAndPassword(
      email,
      password,
    );

    if (!mounted) return;

    setState(() {
      _errorMessage = errorMessage ?? '';
      _isLoading = false;
    });

    if (errorMessage == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  void _clearErrorMessage() {
    if (_errorMessage.isNotEmpty) {
      setState(() {
        _errorMessage = '';
      });
    }
  }
}
