import 'package:flutter/material.dart';

import '../models/wellness_result.dart';
import '../utils/responsive.dart';

class ResultView extends StatelessWidget {
  final int score;
  final int maxScore;
  final int minScore;
  final int questionCount;
  final WellnessResult result;
  final VoidCallback onRestart;

  const ResultView({
    super.key,
    required this.score,
    required this.maxScore,
    required this.minScore,
    required this.questionCount,
    required this.result,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final wide = r.isLandscape || r.isLarge;

    final summary = _SummaryCard(score: score, maxScore: maxScore, result: result);
    final details = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _RecommendationCard(result: result),
        const SizedBox(height: 16),
        _StatsPanel(
          score: score,
          maxScore: maxScore,
          questionCount: questionCount,
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton.icon(
            onPressed: onRestart,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Restart Assessment'),
          ),
        ),
      ],
    );

    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: summary),
          const SizedBox(width: 20),
          Expanded(flex: 6, child: details),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [summary, const SizedBox(height: 16), details],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final int score;
  final int maxScore;
  final WellnessResult result;

  const _SummaryCard(
      {required this.score, required this.maxScore, required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive(context);
    final gauge = r.isSmall ? 130.0 : 160.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your Wellness Score', style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: score / maxScore),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) => SizedBox(
                width: gauge,
                height: gauge,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 12,
                        strokeCap: StrokeCap.round,
                        color: result.color,
                        backgroundColor: result.color.withAlpha(35),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$score',
                            style: theme.textTheme.headlineLarge
                                ?.copyWith(color: result.color)),
                        Text('out of $maxScore',
                            style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Icon(result.icon, color: result.color, size: 34),
            const SizedBox(height: 8),
            Text('Classification', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(
              result.title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(color: result.color),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final WellnessResult result;
  const _RecommendationCard({required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lightbulb_rounded, color: result.color),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recommendation', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(result.recommendation,
                      style: theme.textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Responsive statistics: 4 tiles in a row on wide space, 2x2 on narrow.
class _StatsPanel extends StatelessWidget {
  final int score;
  final int maxScore;
  final int questionCount;

  const _StatsPanel({
    required this.score,
    required this.maxScore,
    required this.questionCount,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (score / maxScore * 100).round();
    final avg = (score / questionCount).toStringAsFixed(1);

    final stats = [
      ('Total Score', '$score', Icons.stars_rounded),
      ('Max Score', '$maxScore', Icons.flag_rounded),
      ('Percentage', '$percent%', Icons.percent_rounded),
      ('Avg / Question', avg, Icons.analytics_rounded),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 480 ? 4 : 2;
        const gap = 12.0;
        final tileWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final s in stats)
              SizedBox(
                width: tileWidth,
                child: _StatTile(label: s.$1, value: s.$2, icon: s.$3),
              ),
          ],
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatTile(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Column(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(height: 6),
            Text(value, style: theme.textTheme.titleLarge),
            const SizedBox(height: 2),
            Text(label,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}