library puzzles;

import 'dart:io';
import 'dart:convert';
import 'package:logging/logging.dart';
import 'day/01/day_01.dart';

/// Part of a daily puzzle
class PuzzlePart {
  final String? input;
  PuzzleResult? result;
  PuzzlePart({required this.input});
}

/// Daily puzzle context including parts
class PuzzleContext {
  final int day;
  final Logger log;
  List<PuzzlePart> parts = [];
  PuzzlePart part([int? i]) => i == null ? parts.last : parts[i];
  PuzzleContext({required this.log, required this.day});
}

/// Result of puzzle solution
class PuzzleResult<T> {
  final T data;
  PuzzleResult({required this.data});
  @override
  String toString() => '$data';
}

typedef DaySolutionFactory = AdventOfCodeDay Function();
final allSolutions = <int, DaySolutionFactory>{1: () => Day01()};

abstract class AdventOfCodeDay {
  List<PuzzleResult Function(PuzzleContext ctx)> solutions();

  static PuzzleContext solve(
      {required int day, required PuzzleContext ctx, String? sampleInput}) {
    if (!allSolutions.containsKey(day)) {
      ctx.log.severe('Day $day is not implemented yet!');
      exit(1);
    }

    final puzzle = allSolutions[day]!();
    var dayPretty = day.toString().padLeft(2, '0');
    final dayPath = 'lib/day/$dayPretty/';
    final solutions = puzzle.solutions();

    ctx.log.info('Solving day $day puzzle with ${solutions.length} part(s)...');

    for (var part in solutions) {
      var partIdx = solutions.indexOf(part);

      // read input file

      final inputFile = File('${dayPath}input_part_${partIdx + 1}.txt');
      final inputData =
          inputFile.existsSync() ? inputFile.readAsStringSync() : null;
      ctx.log.fine(
          'Solving part ${partIdx + 1} ${inputData != null ? '(with input)' : ''}...');
      ctx.parts.add(PuzzlePart(input: sampleInput ?? inputData));

      // solve
      ctx.part().result = part(ctx);
      ctx.log.info('Part ${partIdx + 1} result=${ctx.part().result}');

      // write output file
      if (ctx.part().result != null) {
        File('${dayPath}output_part_${partIdx + 1}.json').writeAsBytesSync(
            utf8.encode(json.encode(ctx.part().result?.data)));
      }
    }
    return ctx;
  }
}
