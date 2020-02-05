import 'package:args/command_runner.dart';
import 'package:lenox/src/autoloader.dart';

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
  void run() async {
    await Prebuild().main();

    await Router()
      .router(logger: false);
  }
}