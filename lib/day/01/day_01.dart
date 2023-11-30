import '../../advent_of_code.dart';

class Day01 implements AdventOfCodeDay {
  @override
  solutions() => [
        (PuzzleContext ctx) {
          return PuzzleResult<List>(data: [42, ctx.part().input]);
        },
      ];
}
