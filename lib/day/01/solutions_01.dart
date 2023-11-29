import '../../advent_of_code.dart';

class Solutions01 implements AdventOfCodeDay {
  @override
  solutions() => [
        (PuzzleContext ctx) {
          return PuzzleResult(data: [42, ctx.part().input]);
        },
      ];
}
