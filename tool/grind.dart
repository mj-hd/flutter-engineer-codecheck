// ignore_for_file: avoid_print

import 'dart:async';

import 'package:grinder/grinder.dart';

void main(args) => grind(args);

@Task()
Future<void> start() async {
  await Future.any([
    runAsync('fvm', arguments: [
      'flutter',
      'pub',
      'run',
      'build_runner',
      'watch',
    ]),
    runAsync(
      'fvm',
      arguments: ['flutter', 'run'],
    ),
  ]);
}

@Task()
void analyze() {
  run('fvm', arguments: ['flutter', 'pub', 'run', 'build_runner', 'build']);
  run('fvm', arguments: ['flutter', 'analyze']);
}

@Task()
void test() {
  run('fvm', arguments: ['flutter', 'pub', 'run', 'build_runner', 'build']);
  run('fvm', arguments: ['flutter', 'test']);
}

@DefaultTask()
void build() {
  run('fvm', arguments: ['flutter', 'pub', 'run', 'build_runner', 'build']);
  run('fvm', arguments: ['flutter', 'build']);
}

@Task()
void clean() {
  run('fvm', arguments: ['flutter', 'clean']);
}
