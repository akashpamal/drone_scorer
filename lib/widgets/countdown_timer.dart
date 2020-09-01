import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  int timeRemaining = 120;
  bool gameOver = false;

  void stopGame() {
    this.gameOver = true;
  }

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer _timer;
  Color textColor = Colors.white;

  @override
  void initState() {
    super.initState();
    this.startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (widget.timeRemaining < 1 || widget.gameOver) {
            this.textColor = Colors.red;
            timer.cancel();
          } else {
            widget.timeRemaining = widget.timeRemaining - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "${widget.timeRemaining}",
        style: TextStyle(color: this.textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
