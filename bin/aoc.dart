import 'dart:io';
import 'package:advent_of_code_2023/advent_of_code.dart';
import 'package:logging/logging.dart';

/// CLI for executing daily puzzles
void main(List<String> arguments) {
  // configure logging
  final verboseLogging = arguments.contains('debug');
  Logger.root.level = verboseLogging ? Level.ALL : Level.INFO;
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName}/${record.level.name}: ${record.message}');
  });

  if (arguments.isEmpty) {
    final log = Logger('AOC23');
    log.severe('Expected first parameter to be the day number (int)');
    exit(1);
  }

  // parse day
  final day = int.parse(arguments.first);
  final log = Logger('AOC23/DAY_$day');

  // Solve puzzle
  final context = PuzzleContext(log: log, day: day);
  AdventOfCodeDay.solve(day: day, ctx: context);
}
