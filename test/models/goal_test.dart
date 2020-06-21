import 'package:build/models/goal.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
    group('Goal model tests', () {

      Goal goal;

      setUp(() {
        goal = Goal(0, 'title', 0, 'countUnit', 1);
      });

      test('Goal count initial value should be zero', () {
        expect(goal.count, 0);
      });

      test('Increment should add count', () {
        goal.increment();

        expect(goal.count, 1);
      });

      test('Decrement when count above zero should decrease count', () {
        goal.count = 5;

        goal.decrement();

        expect(goal.count, 4);
      });

      test('Decrement when count equals to zero should not decrease count', () {
        goal.decrement();

        expect(goal.count, 0);
      });

      test('Goal could not allow negative number on count value', (){
        expect(() => Goal(1, 'title', -1, 'countUnit', 1), throwsAssertionError);
      });
    });
}