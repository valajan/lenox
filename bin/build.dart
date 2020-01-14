import 'src/compile_css.dart';
import 'src/create_directory.dart';
import 'src/compile_dart_to_js.dart';
import 'src/compile_md_to_html.dart';

void main(List<String> arguments) async {
  bool verbose = arguments.contains('-js');

  print('Build in progres !');

  final createDirectory = CreateDirectory();
  createDirectory.main();

  final compileDartToJs = CompileDartToJs();
  compileDartToJs.main(verbose);

  final compileMdToHtml = CompileMdToHtml();
  compileMdToHtml.main();

  final compileCss = CompileCss();
  compileCss.main();

}