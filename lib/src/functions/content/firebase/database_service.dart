import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuizResult {
  final DateTime date;
  final String category;
  final String subCategory;
  final String difficulty;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int score;

  QuizResult({
    required this.date,
    required this.category,
    required this.subCategory,
    required this.difficulty,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.wrongAnswers,
    required this.score,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'category': category,
      'subCategory': subCategory,
      'difficulty': difficulty,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'score': score,
    };
  }
}

class DatabaseService {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save quiz results
  Future<void> saveQuizResult(QuizResult result) async {
    final docRef = _firestore
        .collection('data')
        .doc(user!.uid)
        .collection('quizResults')
        .doc();

    await docRef.set(result.toMap());

    await updateLeaderboardScore();
  }

  // Fetch quiz results
  Future<List<QuizResult>> fetchQuizResults() async {
    final querySnapshot = await _firestore
        .collection('data')
        .doc(user!.uid)
        .collection('quizResults')
        .orderBy('date', descending: true)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return QuizResult(
        date: (data['date'] as Timestamp).toDate(),
        category: data['category'],
        subCategory: data['subCategory'],
        difficulty: data['difficulty'],
        totalQuestions: data['totalQuestions'],
        correctAnswers: data['correctAnswers'],
        wrongAnswers: data['wrongAnswers'],
        score: data['score'],
      );
    }).toList();
  }

  // Save leaderboard score
  Future<void> updateLeaderboardScore() async {
    final results = await fetchQuizResults();
    if (results.isEmpty) {
      log('No quiz results available to update leaderboard score.');
      return;
    }

    // Get the last quiz result's score
    final presentScore = results.first.score;
    final previousScore = results.length > 1 ? results[1].score : 0;

    // Calculate totalScore for leaderboardScore
    int totalScore = results.fold(
      0,
      (total, result) => total + result.score,
    );

    // Update leaderboardScore and previousScore
    await FirebaseFirestore.instance.collection('data').doc(user!.uid).update({
      'previousScore': previousScore,
      'presentScore': presentScore,
      'leaderboardScore': totalScore,
    });
  }

  // Fetch leaderboard score
  Future<List<Map<String, dynamic>>> fetchLeaderboard() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('data')
        .orderBy('leaderboardScore', descending: true)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'name': data['name'],
        'previousScore': data['previousScore'],
        'presentScore': data['presentScore'],
        'leaderboardScore': data['leaderboardScore'],
        'uid': data['uid'],
      };
    }).toList();
  }
}
