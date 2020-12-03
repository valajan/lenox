import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:lenox/cli.dart';

void main(List<String> args) {
  CommandRunner(title, description)
    ..addCommand(BuildCommand())
    ..addCommand(StartCommand())
    ..addCommand(InitCommand())
    ..run(args).catchError((error) {
      print(error);
      exit(64);
    });
}