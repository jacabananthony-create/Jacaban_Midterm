import 'package:flutter/material.dart';

class ProgressHeader extends StatelessWidget {
  final int current; // 1-based
  final int total;
  final int runningScore;

  const ProgressHeader({
    super.key,
    required this.current,
    required this.total,
    required this.runningScore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Question $current of $total',
                style: theme.textTheme.titleMedium),
            Row(
              children: [
                Icon(Icons.bolt_rounded,
                    size: 20, color: theme.colorScheme.secondary),
                const SizedBox(width: 4),
                Text('Score: $runningScore',
                    style: theme.textTheme.titleMedium),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: (current - 1) / total),
            duration: const Duration(milliseconds: 400),
            builder: (context, value, _) =>
                LinearProgressIndicator(value: value),
          ),
        ),
      ],
    );
  }
}