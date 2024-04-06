abstract class QuizEvent {}

class AnswerQuestionEvent extends QuizEvent {
  final int answer;

  AnswerQuestionEvent({required this.answer});
}

class NextQuestionEvent extends QuizEvent {}

class ResetQuizEvent extends QuizEvent {}

class StartGameEvent extends QuizEvent {}
