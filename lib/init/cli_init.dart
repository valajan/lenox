import 'package:args/command_runner.dart';
import 'package:lenox/src/autoloader.dart';

class InitCommand extends Command {
  @override
  final name = 'init';

  @override
  final description = 'Init a Lenox static site';

  InitCommand() {
    argParser.addFlag('verbose',
        abbr: 'v', negatable: false, help: 'Enable verbose');
  }

  @override
  void run() async {
    await Init().main();
  }
}
