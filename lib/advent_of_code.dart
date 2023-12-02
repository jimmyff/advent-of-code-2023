library puzzles;

import 'dart:io';
import 'dart:convert';
import 'package:logging/logging.dart';
import 'day/01/day_01.dart';
import 'day/02/day_02.dart';

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
  String? get input => part().input;
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
final allSolutions = <int, DaySolutionFactory>{
  1: () => Day01(),
  2: () => Day02(),
};

abstract class AdventOfCodeDay {
  List<PuzzleResult Function(PuzzleContext ctx)> solutions();

  static AdventOfCodeDay day(int day) => allSolutions[day]!();

  static PuzzleContext solvePart({
    required PuzzleContext ctx,
    required AdventOfCodeDay day,
    required int partIndex,
    required String? input,
  }) {
    final parts = day.solutions();

    if (parts.length < partIndex) {
      throw RangeError('Part $partIndex solution not implemented!');
    }

    ctx.log.info('Solving day ${ctx.day} part $partIndex...');
    ctx.parts.add(PuzzlePart(input: input));
    ctx.part().result = parts[partIndex](ctx);
    return ctx;
  }

  static PuzzleContext solveAllParts(
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
    }
    return ctx;
  }
}
