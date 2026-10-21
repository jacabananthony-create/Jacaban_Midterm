import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class StudentInfoCard extends StatelessWidget {
  final String name;
  final String section;

  const StudentInfoCard({super.key, required this.name, required this.section});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final r = Responsive(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(r.isSmall ? 14 : 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: scheme.primary.withAlpha(30),
              child:
                  Icon(Icons.person_rounded, size: 30, color: scheme.primary),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    section,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurface.withAlpha(160),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}