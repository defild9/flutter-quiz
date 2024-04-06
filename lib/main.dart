import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/blocs/quiz_bloc.dart';
import 'package:quiz/blocs/quiz_state.dart';
import 'package:quiz/screens/result_screen.dart';

import 'screens/quiz_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => QuizBloc(),
        child: Quiz(),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mega Quiz'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state is QuizInitial) {
            return QuizScreen();
          } else if (state is QuizAnswered) {
            return ResultScreen(score: state.score);
          } else {
            return const Text('Unexpected state');
          }
        },
      ),
    );
  }
}
