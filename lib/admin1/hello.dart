import 'package:flutter/material.dart';

class DailyPage1 extends StatelessWidget {
  
  const DailyPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Hello, Flutter!',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xff0085E0),
            fontSize: 48,
            fontWeight: FontWeight.bold
        )
      ),
    );
  }
}
