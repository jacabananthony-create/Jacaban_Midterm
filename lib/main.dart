import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const CampusWellnessApp());

class CampusWellnessApp extends StatefulWidget {
  const CampusWellnessApp({super.key});

  @override
  State<CampusWellnessApp> createState() => _CampusWellnessAppState();
}

class _CampusWellnessAppState extends State<CampusWellnessApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Wellness Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(
        isDark: _isDark,
        onThemeChanged: (value) => setState(() => _isDark = value),
      ),
    );
  }
}