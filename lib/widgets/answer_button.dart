import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class AnswerButton extends StatelessWidget {
  final String text;
  final String label; // A, B, C, D
  final bool selected;
  final VoidCallback? onTap;

  const AnswerButton({
    super.key,
    required this.text,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final r = Responsive(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected ? scheme.primary.withAlpha(30) : scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? scheme.primary : scheme.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16, vertical: r.isSmall ? 12 : 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor:
                      selected ? scheme.primary : scheme.primary.withAlpha(25),
                  child: selected
                      ? Icon(Icons.check_rounded,
                          size: 18, color: scheme.onPrimary)
                      : Text(
                          label,
                          style: TextStyle(
                            color: scheme.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: r.font(16),
                          fontWeight:
                              selected ? FontWeight.w700 : FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}