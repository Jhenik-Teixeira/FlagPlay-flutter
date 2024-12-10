import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  final int timeLimit;
  final Function onTimeUp;

  const TimerWidget({required this.timeLimit, required this.onTimeUp, super.key});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int _remainingTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.timeLimit;
    _startTimer();
  }

  // Função para iniciar o contador regressivo
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        widget.onTimeUp(); // Chama a função passada quando o tempo acabar
        _timer.cancel(); // Para o timer
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Tempo restante: $_remainingTime segundos',
      style: const TextStyle(fontSize: 20),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Certifique-se de cancelar o timer ao sair da tela
    super.dispose();
  }
}
