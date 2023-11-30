import 'package:test/test.dart';
import 'package:logging/logging.dart';
import 'package:advent_of_code_2023/advent_of_code.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName}/${record.level.name}: ${record.message}');
  });
  final log = Logger('AOC23');

  final context = PuzzleContext(log: log, day: 1);
  final result = AdventOfCodeDay.solve(
      day: context.day, ctx: context, sampleInput: 'hola');

  group('Advent of Code', () {
    test('Has List', () {
      expect(result.part().result?.data, isList);
    });
    test('Correct result', () {
      expect(result.part().result?.data[1], equals('hola'));
    });
  });
}
