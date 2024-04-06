import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/blocs/quiz_bloc.dart';
import 'package:quiz/blocs/quiz_event.dart';
import 'package:quiz/widgets/answer_button.dart';
import 'package:quiz/widgets/custom_button.dart';
import 'package:quiz/widgets/quiz_detail_bar.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizBloc = BlocProvider.of<QuizBloc>(context);
    final question = quizBloc.questions[quizBloc.currentQuestionIndex];
    final answers = question.answers;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const QuizDetailBar(),
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth * 0.9,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.indigoAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          question.questionText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        ...answers.map((answer) {
                          return AnswerButton(
                            buttonText: answer.text,
                            onPressed: () => quizBloc.add(
                              AnswerQuestionEvent(answer: answer.score),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
        CustomButton(
          onPressed: () => {quizBloc.add(NextQuestionEvent())},
          text: 'Next',
          color: Colors.indigoAccent,
        ),
      ],
    );
  }
}
