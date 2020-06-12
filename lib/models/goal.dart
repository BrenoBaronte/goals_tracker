class Goal {
  String title;
  int count = 0;
  String countUnit = 'days';

  void increment() => count++;

  void decrement() {
    if (count != 0)
      count--;
  }

  Goal(this.title);
}