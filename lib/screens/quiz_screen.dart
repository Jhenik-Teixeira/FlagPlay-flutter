import 'package:flutter/material.dart';
import 'result_screen.dart';
import '../data/questions_data.dart';
import '../widgets/timer_widget.dart';

class QuizScreen extends StatefulWidget {
  final int timeLimit;

  const QuizScreen({required this.timeLimit, super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  String selectedAnswer = '';
  late int remainingTime;
  bool isTimeUp = false;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.timeLimit;
  }

  void _timeUp() {
    setState(() {
      isTimeUp = true;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(score: score),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flag Quiz'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TimerWidget(
              timeLimit: widget.timeLimit,
              onTimeUp: _timeUp,
            ),
            const SizedBox(height: 20),
            Text(
              'Questão ${currentQuestionIndex + 1} de ${questions.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    question['flag'],
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  ...question['options'].map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        width: double.infinity, // Botão ocupa a largura máxima disponível
                        height: 60, // Altura fixa para os botões
                        child: ElevatedButton(
                          onPressed: isTimeUp
                              ? null
                              : () {
                                  setState(() {
                                    selectedAnswer = option;
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedAnswer == option
                                ? Colors.blue.shade700
                                : Colors.grey.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            option,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isTimeUp
                  ? null
                  : () {
                      if (selectedAnswer == question['correctAnswer']) {
                        score++;
                      }
                      if (currentQuestionIndex + 1 < questions.length) {
                        setState(() {
                          currentQuestionIndex++;
                          selectedAnswer = '';
                        });
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(score: score),
                          ),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                backgroundColor: Colors.green.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Responder',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
