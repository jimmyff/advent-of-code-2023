import 'package:test/test.dart';
import 'package:logging/logging.dart';
import 'package:advent_of_code_2023/advent_of_code.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName}/${record.level.name}: ${record.message}');
  });
  final log = Logger('AOC23');

  group('Part 1', () {
    final result = AdventOfCodeDay.solvePart(
        day: AdventOfCodeDay.day(2),
        partIndex: 0,
        ctx: PuzzleContext(log: log, day: 2),
        input: '''Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green''');

    test('Sample input gives correct output', () {
      expect(result.part().result?.data, equals(8));
    });
  });
  group('Part 2', () {
    final result = AdventOfCodeDay.solvePart(
        day: AdventOfCodeDay.day(2),
        partIndex: 1,
        ctx: PuzzleContext(log: log, day: 2),
        input: '''Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green''');

    test('Sample input gives correct output', () {
      expect(result.part().result?.data, equals(2286));
    });
  });
}
