import 'dart:io';
import 'package:markdown/markdown.dart';

void main() {
  print('Build in progress !');
  Directory('build').create();
  Directory('build/css').create();
  Directory('views').list().listen((contents) {
    var safeName = contents.uri.path.replaceAll('views/', '').replaceAll('.md', '');
    File('${contents.path}').readAsString().then((contents) {
      var convertor = markdownToHtml(contents,
        inlineSyntaxes: [new InlineHtmlSyntax()]);
      File('static/layout.html').readAsString().then((layout) {
        var layoutFile = layout.toString().replaceAll('{{ body }}', convertor);
        File('build/$safeName.html').writeAsString(layoutFile);
      });
    });
  });
  Directory('static/css/').list().listen((contents) {
    var cssSafe = contents.path.replaceAll('static/css/', '');
    print(cssSafe);
    File(contents.path).readAsString().then((cssContents) {
      File('build/css/$cssSafe').writeAsString(cssContents);
    });
  });
  print('Build done ! Check the build folder');
}