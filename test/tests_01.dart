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
        day: AdventOfCodeDay.day(1),
        partIndex: 0,
        ctx: PuzzleContext(log: log, day: 1),
        input: '''1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet''');

    test('Sample input gives correct output', () {
      expect(result.part().result?.data, equals(142));
    });
  });

  group('Part 2', () {
    final result = AdventOfCodeDay.solvePart(
        day: AdventOfCodeDay.day(1),
        partIndex: 1,
        ctx: PuzzleContext(log: log, day: 1),
        input: '''two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen''');

    test('Sample input gives correct output', () {
      expect(result.part().result?.data, equals(281));
    });
  });
}
