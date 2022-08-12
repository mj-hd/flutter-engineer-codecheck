// ignore_for_file: avoid_print

import 'dart:async';

import 'package:grinder/grinder.dart';

void main(args) => grind(args);

@Task()
Future<void> start() async {
  final flutter = provideFlutterCommand();
  await Future.any([
    runAsync(flutter.exec, arguments: [
      ...flutter.prefix,
      'pub',
      'run',
      'build_runner',
      'watch',
    ]),
    runAsync(
      flutter.exec,
      arguments: [...flutter.prefix, 'run'],
    ),
  ]);
}

@Task()
void analyze() {
  final flutter = provideFlutterCommand();
  run(
    flutter.exec,
    arguments: [...flutter.prefix, 'pub', 'run', 'build_runner', 'build'],
  );
  run(flutter.exec, arguments: [...flutter.prefix, 'analyze']);
}

@Task()
void test() {
  final flutter = provideFlutterCommand();
  run(
    flutter.exec,
    arguments: [...flutter.prefix, 'pub', 'run', 'build_runner', 'build'],
  );
  run(flutter.exec, arguments: [...flutter.prefix, 'test']);
}

@DefaultTask()
void build() {
  final flutter = provideFlutterCommand();
  run(
    flutter.exec,
    arguments: [...flutter.prefix, 'pub', 'run', 'build_runner', 'build'],
  );
  run(flutter.exec, arguments: [...flutter.prefix, 'build']);
}

@Task()
void clean() {
  final flutter = provideFlutterCommand();
  run(flutter.exec, arguments: [...flutter.prefix, 'clean']);
}

class FlutterCommand {
  FlutterCommand({
    required this.exec,
    required this.prefix,
  });

  FlutterCommand.native()
      : exec = 'flutter',
        prefix = [];

  FlutterCommand.fvm()
      : exec = 'fvm',
        prefix = ['flutter'];

  final String exec;
  final List<String> prefix;
}

FlutterCommand provideFlutterCommand() {
  final args = context.invocation.arguments;
  bool useNativeFlutter = args.getFlag('use-native-flutter');

  return useNativeFlutter ? FlutterCommand.native() : FlutterCommand.fvm();
}
