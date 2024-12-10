import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String flagPath;

  const QuestionWidget({Key? key, required this.flagPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Image.asset(
        flagPath,
        height: 150,
        fit: BoxFit.contain,
      ),
    );
  }
}
