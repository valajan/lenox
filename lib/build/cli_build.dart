import 'package:lenox/build/compile_assets.dart';
import 'package:lenox/build/compile_css.dart';
import 'package:lenox/build/create_directory.dart';
import 'package:lenox/build/compile_dart_to_js.dart';
import 'package:lenox/build/compile_md_to_html.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';

class BuildCommand extends Command {
  @override
  final name = 'build';

  @override
  final description = 'Generate static files';

  BuildCommand() {
    argParser.addFlag('verbose',
        abbr: 'v', negatable: false, help: 'Enable verbose');
  }

  @override
  void run() async {
    var parser = ArgParser();
    parser.addFlag('js', defaultsTo: true);

    print('Build in progres !');

    final createDirectory = CreateDirectory();
    createDirectory.main();

    final compileDartToJs = CompileDartToJs();
    compileDartToJs.main(true);

    final compileMdToHtml = CompileMdToHtml();
    compileMdToHtml.main();

    final compileAssets = CompileAssets();
    compileAssets.main();

    final compileCss = CompileCss();
    compileCss.main();
  }
}
