import 'package:flutter/material.dart';
import 'package:quizz/src/functions/authentication/auth/auth_repository.dart';
import 'package:quizz/src/functions/authentication/screens/signUp/verification_screen.dart';
import 'package:quizz/src/widgets/elevated_button.dart';
import 'package:quizz/src/functions/authentication/widgets/form/text_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  final AuthService _authService = AuthService();

  bool _isLoading = false;

  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
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
            focusNode: _nameFocusNode,
            controller: _nameController,
            labelText: "Name",
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
            focusNode: _emailFocusNode,
            controller: _emailController,
            labelText: "Email",
            validator: (value) {
              if (value == null || value.isEmpty) {
                _errorMessage = 'Please enter all credentials';
              }
              return null;
            },
            prefixIcon: Icons.email,
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
          const SizedBox(height: 30),
          ElevatedBtn(
            loading: _isLoading,
            onPressed: _submitForm,
            text: "SIGN UP",
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      setState(() {
        _isLoading = true;
      });

      _signUp(name, email, password);

      FocusScope.of(context).unfocus();
    }
  }

  void _signUp(
    String name,
    String email,
    String password,
  ) async {
    String? errorMessage = await _authService.signUpWithEmailAndPassword(
      name,
      email,
      password,
    );

    if (!mounted) return;

    setState(() {
      _errorMessage = errorMessage ?? '';
      _isLoading = false;
    });

    if (errorMessage == null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const VerificationScreen(),
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
