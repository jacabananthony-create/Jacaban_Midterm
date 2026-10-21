import 'package:flutter/material.dart';

import '../data/questions_data.dart';
import '../models/wellness_result.dart';
import '../utils/responsive.dart';
import '../widgets/result_view.dart';
import 'assessment_screen.dart';

class ResultsScreen extends StatelessWidget {
  final int score;

  const ResultsScreen({super.key, required this.score});

  void _restart(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AssessmentScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final count = wellnessQuestions.length;
    final maxScore = wellnessQuestions
        .map((q) => q.options.map((o) => o.score).reduce((a, b) => a > b ? a : b))
        .reduce((a, b) => a + b);
    final minScore = count;

    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(r.pagePadding),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: r.maxContentWidth),
              child: ResultView(
                score: score,
                maxScore: maxScore,
                minScore: minScore,
                questionCount: count,
                result: WellnessResult.fromScore(score), // updates with score
                onRestart: () => _restart(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}