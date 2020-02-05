import 'package:lenox/router.dart';
import 'package:args/command_runner.dart';

class StartCommand extends Command {
  @override
  final name = 'start';

  @override
  final description = 'Start Lenox server';

  StartCommand() {
    argParser.addFlag('verbose',
      abbr: 'v', negatable: false, help: 'Enable verbose');
  }

  @override
  void run() {
    Router()
      .router(logger: false);
  }
}