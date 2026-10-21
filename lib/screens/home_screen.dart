import 'package:flutter/material.dart';

import '../utils/responsive.dart';
import '../widgets/student_info_card.dart';
import 'assessment_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  
  static const String studentName = 'Anthony Jacaban';
  static const String studentSection = 'BSCS-3';

  void _start(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AssessmentScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final r = Responsive(context);

    final hero = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [scheme.primary, scheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(Icons.self_improvement_rounded,
              size: r.isSmall ? 56 : 72, color: Colors.white),
        ),
        const SizedBox(height: 24),
        Text(
          'Campus Wellness Tracker',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineLarge
              ?.copyWith(fontSize: r.font(32), color: scheme.primary),
        ),
        const SizedBox(height: 10),
        Text(
          'Evaluate your current study-life balance.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: r.font(17),
            color: scheme.onSurface.withAlpha(170),
          ),
        ),
      ],
    );

    final actions = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const StudentInfoCard(name: studentName, section: studentSection),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () => _start(context),
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text('Start Assessment'),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              size: 20),
          Switch.adaptive(value: isDark, onChanged: onThemeChanged),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(r.pagePadding),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: r.maxContentWidth),
              // Orientation adaptation: side-by-side in landscape.
              child: r.isLandscape
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: hero),
                        const SizedBox(width: 32),
                        Expanded(child: actions),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        hero,
                        const SizedBox(height: 32),
                        actions,
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}