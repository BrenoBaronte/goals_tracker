import 'package:build/models/goal.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
    group('Goal model tests', () {
      test('Goal count initial value should be zero', () {
        final goal = Goal('dumb title');

        expect(goal.count, 0);
      });

      test('Increment should add count', () {
        final goal = Goal('dumb title');

        goal.increment();

        expect(goal.count, 1);
      });

      test('Decrement when count above zero should decrease count', () {
        final goal = Goal('dumb title');

        goal.count = 5;

        goal.decrement();

        expect(goal.count, 4);
      });

      test('Decrement when count equals to zero should not decrease count', () {
        final goal = Goal('dumb title');

        goal.decrement();

        expect(goal.count, 0);
      });
    });
}