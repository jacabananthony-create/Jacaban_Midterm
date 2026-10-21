import 'package:flutter/material.dart';

import '../models/question.dart';
import '../utils/responsive.dart';

class QuestionDisplay extends StatelessWidget {
  final Question question;
  final int number;
  final int total;

  const QuestionDisplay({
    super.key,
    required this.question,
    required this.number,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final r = Responsive(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(r.isSmall ? 18 : 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: scheme.secondary.withAlpha(35),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                question.category.toUpperCase(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.secondary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Question $number of $total',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurface.withAlpha(150),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              question.text,
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontSize: r.font(24)),
            ),
          ],
        ),
      ),
    );
  }
}