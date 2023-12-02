import '../../advent_of_code.dart';

// https://adventofcode.com/2023/day/2
class Day02 implements AdventOfCodeDay {
  Map<int, List<Map<String, int>>> parseGames(String input) =>
      Map.fromEntries(RegExp(r'^^Game\s([0-9]+):(.*)$', multiLine: true)
          .allMatches(input)
          .map((m) => MapEntry(
              int.parse(m.group(1)!),
              m
                  .group(2)!
                  .split(';')
                  .map((e) => Map.fromEntries(RegExp(r'(\d+) ([a-z]+)')
                      .allMatches(e)
                      .map((e) =>
                          MapEntry(e.group(2)!, int.parse(e.group(1)!)))))
                  .toList())));

  @override
  solutions() => [
        // Part 1
        (PuzzleContext ctx) {
          final games = Map.fromEntries(parseGames(ctx.input!).entries.where(
              (e) =>
                  e.value
                      .map((s) =>
                          (s['red'] ?? 0) > 12 ||
                          (s['green'] ?? 0) > 13 ||
                          (s['blue'] ?? 0) > 14)
                      .contains(true) ==
                  false));

          return PuzzleResult<int>(data: games.keys.fold(0, (a, b) => a + b));
        },
        // Part 2
        (PuzzleContext ctx) {
          final games = Map.fromEntries(
              parseGames(ctx.input!).entries.map((e) => MapEntry(
                  e.key,
                  e.value
                      .fold(
                          <String, int>{'red': 0, 'green': 0, 'blue': 0},
                          (m, s) => {
                                'red': (s['red'] ?? 0) > m['red']!
                                    ? s['red']!
                                    : m['red']!,
                                'green': (s['green'] ?? 0) > m['green']!
                                    ? s['green']!
                                    : m['green']!,
                                'blue': (s['blue'] ?? 0) > m['blue']!
                                    ? s['blue']!
                                    : m['blue']!
                              })
                      .values
                      .fold(1, (a, b) => a * b))));
          return PuzzleResult<int>(data: games.values.fold(0, (a, b) => a + b));
        }
      ];
}
