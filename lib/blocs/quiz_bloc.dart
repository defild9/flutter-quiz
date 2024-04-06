import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/blocs/quiz_event.dart';
import 'package:quiz/blocs/quiz_state.dart';

import '../models/answer.dart';
import '../models/question.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  int score = 0;
  int currentQuestionIndex = 0;

  final List<Question> questions = [
    Question(
      questionText: 'What is the capital of France?',
      answers: [
        Answer(text: 'Berlin', score: 0),
        Answer(text: 'Paris', score: 1),
        Answer(text: 'Madrid', score: 0),
        Answer(text: 'London', score: 0),
      ],
    ),
    Question(
      questionText: 'What is 7 + 3?',
      answers: [
        Answer(text: '10', score: 1),
        Answer(text: '12', score: 0),
        Answer(text: '8', score: 0),
        Answer(text: '6', score: 0),
      ],
    ),
    Question(
      questionText: 'Which is the tallest mammal?',
      answers: [
        Answer(text: 'Elephant', score: 0),
        Answer(text: 'Giraffe', score: 1),
        Answer(text: 'Kangaroo', score: 0),
        Answer(text: 'Horse', score: 0),
      ],
    ),
    Question(
      questionText: 'What is the largest ocean on Earth?',
      answers: [
        Answer(text: 'Atlantic Ocean', score: 0),
        Answer(text: 'Arctic Ocean', score: 0),
        Answer(text: 'Indian Ocean', score: 0),
        Answer(text: 'Pacific Ocean', score: 1),
      ],
    ),
    Question(
      questionText: 'Who wrote the play "Hamlet"?',
      answers: [
        Answer(text: 'William Shakespeare', score: 1),
        Answer(text: 'Charles Dickens', score: 0),
        Answer(text: 'Jane Austen', score: 0),
        Answer(text: 'Mark Twain', score: 0),
      ],
    ),
    Question(
      questionText: 'What is the chemical symbol for gold?',
      answers: [
        Answer(text: 'Go', score: 0),
        Answer(text: 'Gl', score: 0),
        Answer(text: 'Au', score: 1),
        Answer(text: 'Ag', score: 0),
      ],
    ),
  ];

  QuizBloc() : super(QuizInitial()) {
    on<AnswerQuestionEvent>(_answerQuestionEvent);
    on<NextQuestionEvent>(_nextQuestionEvent);
    on<StartGameEvent>(_startGameEvent);
    _shuffleQuestions();
  }

  void _answerQuestionEvent(
      AnswerQuestionEvent event, Emitter<QuizState> emit) {
    score += event.answer;
    if (currentQuestionIndex == questions.length - 1) {
      emit(QuizAnswered(score: score));
    } else {
      _nextQuestionEvent(NextQuestionEvent(), emit);
    }
  }

  void _nextQuestionEvent(NextQuestionEvent event, Emitter<QuizState> emit) {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      emit(QuizInitial());
    } else {
      emit(QuizAnswered(score: score));
    }
  }

  void _startGameEvent(StartGameEvent event, Emitter<QuizState> emit) {
    score = 0;
    currentQuestionIndex = 0;
    emit(QuizInitial());
  }

  void _shuffleQuestions() {
    final random = Random();
    questions.shuffle(random);
  }
}
