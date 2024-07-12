import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizz/firebase_options.dart';
import 'package:quizz/src/functions/authentication/screens/signUp/verification_screen.dart';
import 'package:quizz/src/functions/authentication/screens/welcome/welcome_screen.dart';
import 'package:quizz/src/functions/content/screens/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'quizz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              if (snapshot.data!.emailVerified) {
                return const HomeScreen();
              } else {
                return const VerificationScreen();
              }
            } else {
              return const WelcomeScreen();
            }
          }
        },
      ),
    );
  }
}
