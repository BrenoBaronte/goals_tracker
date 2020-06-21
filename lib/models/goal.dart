class Goal {
  final int id;
  String title;
  int count;
  String countUnit;
  int feeling;

  Goal(
    this.id,
    this.title,
    this.count,
    this.countUnit,
    this.feeling,
  ): assert(count >= 0);

  void increment() => count++;

  void decrement() {
    if (count != 0) count--;
  }

  @override
  String toString() {
    return 'id = {$id}, title = {$title}, count = {$count}, '
        'countUnit = {$countUnit}, feeling = {$feeling}';
  }
}
