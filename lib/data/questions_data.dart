import '../models/question.dart';

const List<Question> wellnessQuestions = [
  Question(
    category: 'Sleep',
    text: 'How many hours did you sleep last night?',
    options: [
      AnswerOption(text: 'Less than 4 hours', score: 1),
      AnswerOption(text: '4–6 hours', score: 2),
      AnswerOption(text: 'More than 8 hours', score: 3),
      AnswerOption(text: '7–8 hours', score: 4),
    ],
  ),
  Question(
    category: 'Study',
    text: 'How many hours did you study today?',
    options: [
      AnswerOption(text: 'None', score: 1),
      AnswerOption(text: 'Less than 1 hour', score: 2),
      AnswerOption(text: 'More than 6 hours', score: 3),
      AnswerOption(text: '2–4 hours', score: 4),
    ],
  ),
  Question(
    category: 'Hydration',
    text: 'How many glasses of water did you drink today?',
    options: [
      AnswerOption(text: '0–2 glasses', score: 1),
      AnswerOption(text: '3–4 glasses', score: 2),
      AnswerOption(text: '5–6 glasses', score: 3),
      AnswerOption(text: '7 or more glasses', score: 4),
    ],
  ),
  Question(
    category: 'Activity',
    text: 'How much physical activity did you get today?',
    options: [
      AnswerOption(text: 'None', score: 1),
      AnswerOption(text: 'Light walking', score: 2),
      AnswerOption(text: '15–30 minutes of exercise', score: 3),
      AnswerOption(text: 'More than 30 minutes of exercise', score: 4),
    ],
  ),
  Question(
    category: 'Stress',
    text: 'How stressed do you feel right now?',
    options: [
      AnswerOption(text: 'Extremely stressed', score: 1),
      AnswerOption(text: 'Quite stressed', score: 2),
      AnswerOption(text: 'Slightly stressed', score: 3),
      AnswerOption(text: 'Calm and relaxed', score: 4),
    ],
  ),
  Question(
    category: 'Social',
    text: 'How much time did you spend with friends or family today?',
    options: [
      AnswerOption(text: 'None', score: 1),
      AnswerOption(text: 'A few minutes', score: 2),
      AnswerOption(text: 'About an hour', score: 3),
      AnswerOption(text: 'Several quality hours', score: 4),
    ],
  ),
];