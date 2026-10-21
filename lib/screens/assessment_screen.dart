import 'package:flutter/material.dart';

import '../data/questions_data.dart';
import '../utils/responsive.dart';
import '../widgets/answer_button.dart';
import '../widgets/progress_header.dart';
import '../widgets/question_display.dart';
import 'results_screen.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _index = 0;
  int _totalScore = 0; // running score
  int? _selected;
  bool _locked = false;
  bool _finishing = false;

  Future<void> _onSelect(int optionIndex) async {
    if (_locked) return;
    final option = wellnessQuestions[_index].options[optionIndex];

    setState(() {
      _selected = optionIndex;
      _locked = true;
      _totalScore += option.score; // record the score
    });

    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;

    if (_index == wellnessQuestions.length - 1) {
      setState(() => _finishing = true);
      await Future.delayed(const Duration(milliseconds: 800));
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ResultsScreen(score: _totalScore)),
      );
    } else {
      setState(() {
        _index++;
        _selected = null;
        _locked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final total = wellnessQuestions.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Assessment')),
      body: SafeArea(
        child: _finishing
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator.adaptive(),
                    const SizedBox(height: 16),
                    Text('Calculating your score...',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              )
            : Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: r.maxContentWidth),
                  child: Padding(
                    padding: EdgeInsets.all(r.pagePadding),
                    child: Column(
                      children: [
                        ProgressHeader(
                          current: _index + 1,
                          total: total,
                          runningScore: _totalScore,
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.08, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            ),
                            child: _buildQuestion(r, total),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildQuestion(Responsive r, int total) {
    final question = wellnessQuestions[_index];

    final questionWidget = QuestionDisplay(
      question: question,
      number: _index + 1,
      total: total,
    );

    final answers = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < question.options.length; i++) ...[
          AnswerButton(
            label: String.fromCharCode(65 + i),
            text: question.options[i].text,
            selected: _selected == i,
            onTap: _locked ? null : () => _onSelect(i),
          ),
          if (i != question.options.length - 1) const SizedBox(height: 12),
        ],
      ],
    );

    // Orientation adaptation: Question | Answers in landscape.
    if (r.isLandscape) {
      return Row(
        key: ValueKey(_index),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: SingleChildScrollView(child: questionWidget),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(child: answers),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      key: ValueKey(_index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [questionWidget, const SizedBox(height: 20), answers],
      ),
    );
  }
}