import '../../advent_of_code.dart';

// https://adventofcode.com/2023/day/1
class Day01 implements AdventOfCodeDay {
  @override
  solutions() => [
        // Part 1
        (PuzzleContext ctx) => PuzzleResult<int>(
                data: ctx.input!.split('\n').map((String line) {
              final d =
                  RegExp('([0-9]{1})').allMatches(line).map((e) => e.group(1));
              ctx.log.fine('$line = ${d.first}${d.last}');
              return int.parse('${d.first}${d.last}');
            }).fold(0, (a, b) => a + b)),

        // Part 2
        (PuzzleContext ctx) {
          return PuzzleResult<int>(
              data: ctx.input!
                  .split('\n')
                  .map((line) => int.parse([
                        List.generate(
                            line.length, (index) => line.substring(index)),
                        List.generate(line.length,
                            (index) => line.substring(line.length - 1 - index)),
                      ].map((inputs) {
                        for (var i in inputs) {
                          if (startDigit(i) != null) return startDigit(i);
                        }
                      }).join('')))
                  .fold(0, (a, b) => a + b));
        }
      ];

  // returns an int if the string starts with one (digit or word)
  int? startDigit(String input) {
    final numbers =
        'zero one two three four five six seven eight nine'.split(' ');
    final digitMatch = RegExp('^([0-9]{1})').firstMatch(input);
    final wordMatch = RegExp('^(${numbers.join('|')}){1}').firstMatch(input);
    return digitMatch != null
        ? int.parse(input.substring(0, 1))
        : ((wordMatch != null) ? numbers.indexOf(wordMatch.group(1)!) : null);
  }
}
