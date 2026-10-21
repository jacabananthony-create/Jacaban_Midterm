class AnswerOption {
  final String text;
  final int score;

  const AnswerOption({required this.text, required this.score});
}

class Question {
  final String text;
  final String category;
  final List<AnswerOption> options;

  const Question({
    required this.text,
    required this.category,
    required this.options,
  });
}