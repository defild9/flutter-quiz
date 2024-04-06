abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizAnswered extends QuizState {
  final int score;

  QuizAnswered({required this.score});
}
