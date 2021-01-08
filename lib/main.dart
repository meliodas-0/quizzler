import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  int randomNumber = 0;
  Icon checkIcon = Icon(Icons.check, color: Colors.green);
  Icon wrongIcon = Icon(Icons.close, color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              quizBrain.getQuestionText(randomNumber),
              style: TextStyle(color: Colors.white, fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  checkCorrect(true);
                });
              },
              color: Colors.green,
              child: Text(
                'TRUE',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  checkCorrect(false);
                });
              },
              color: Colors.red,
              height: 20,
              child: Text(
                'FALSE',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }

  void checkCorrect(bool answer) {
    if (randomNumber == quizBrain.getSize() - 1) {
      Alert(
          context: context,
          title: 'You reached the end of the quiz. Thanks for playing',
          buttons: [
            DialogButton(
                child: Text('Replay'),
                onPressed: () {
                  setState(() {
                    reset();
                  });
                  Navigator.pop(context);
                })
          ]).show();
      return;
    }

    if (randomNumber < quizBrain.getSize() - 1) {
      if (answer == quizBrain.getQuestionAnswer(randomNumber))
        scoreKeeper.add(checkIcon);
      else
        scoreKeeper.add(wrongIcon);

      randomNumber++;
    }
  }

  void reset() {
    randomNumber = 0;
    scoreKeeper.clear();
  }
}
