import 'src/compile_css.dart';
import 'src/create_directory.dart';
import 'src/compile_dart_to_js.dart';
import 'src/compile_md_to_html.dart';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  var parser = ArgParser();
  parser.addFlag('js', defaultsTo: true);
  var results = parser.parse(arguments);

  var verboseJs = results['js'];

  print('Build in progres !');

  final createDirectory = CreateDirectory();
  createDirectory.main();

  final compileDartToJs = CompileDartToJs();
  compileDartToJs.main(verboseJs);

  final compileMdToHtml = CompileMdToHtml();
  compileMdToHtml.main();

  final compileCss = CompileCss();
  compileCss.main();
}
