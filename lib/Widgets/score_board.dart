import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final Map<String, int> scores;

  const ScoreBoard({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Scores:\n\nPlayer X: ${scores['X']},      Player O: ${scores['O']}',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
