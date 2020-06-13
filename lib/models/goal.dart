import 'package:flutter/material.dart';

class Goal {
  String title;
  int count = 0;
  String countUnit = 'Days';
  IconData feeling = Icons.sentiment_very_satisfied;

  void increment() => count++;

  void decrement() {
    if (count != 0)
      count--;
  }

  Goal(this.title);
}