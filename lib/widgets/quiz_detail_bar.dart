import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/quiz_bloc.dart';
import '../blocs/quiz_state.dart';
import 'custom_linear_progress_indicator.dart';

class QuizDetailBar extends StatelessWidget {
  const QuizDetailBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        final quizBloc = BlocProvider.of<QuizBloc>(context);
        final progress =
            quizBloc.currentQuestionIndex / quizBloc.questions.length;
        if (state is QuizInitial) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                            width:  MediaQuery.of(context).size.width * 0.9,
                            child: Text(
                              'Question ${quizBloc.currentQuestionIndex + 1}/${quizBloc.questions.length}',
                              style: const TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomLinearProgressIndicator(
                  value: progress,
                  width: MediaQuery.of(context).size.width * 0.9),
              const SizedBox(height: 10),
            ],
          );
        } else {
          return const Text('Unexpected state');
        }
      },
    );
  }
}
