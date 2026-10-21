import 'package:flutter/material.dart';

class WellnessResult {
  final String title;
  final String recommendation;
  final IconData icon;
  final Color color;

  const WellnessResult({
    required this.title,
    required this.recommendation,
    required this.icon,
    required this.color,
  });

  /// 6 questions x (1-4 points) => 6..24
  /// 20-24 Excellent | 14-19 Moderate | 6-13 Needs Improvement
  static WellnessResult fromScore(int score) {
    if (score >= 20) {
      return const WellnessResult(
        title: 'Excellent Wellness Habits',
        recommendation:
            'Great job! Keep maintaining your current habits and share them with classmates.',
        icon: Icons.emoji_events_rounded,
        color: Color(0xFF2E9E6B),
      );
    } else if (score >= 14) {
      return const WellnessResult(
        title: 'Moderate Wellness Habits',
        recommendation:
            'You are on the right track. Try improving one area at a time, such as sleep or breaks.',
        icon: Icons.trending_up_rounded,
        color: Color(0xFFE0A100),
      );
    } else {
      return const WellnessResult(
        title: 'Needs Improvement',
        recommendation:
            'Your routine needs attention. Prioritize sleep, hydration and rest, and talk to a campus counselor if you feel overwhelmed.',
        icon: Icons.favorite_rounded,
        color: Color(0xFFD9534F),
      );
    }
  }
}