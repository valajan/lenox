import 'dart:io';
import 'package:markdown/markdown.dart';

void main() {
  String safeName;
  String convertor;
  String layoutFile;
  String cssSafe;
  print('Build in progress !');
  Directory('build').create();
  Directory('build/css').create();
  Directory('views').list().listen((FileSystemEntity contents) {
    safeName = contents.uri.path.replaceAll('views/', '').replaceAll('.md', '');
    File('${contents.path}').readAsString().then((String contents) {
      convertor = markdownToHtml(contents,
        inlineSyntaxes: <InlineHtmlSyntax>[InlineHtmlSyntax()]);
      File('static/layout.html').readAsString().then((String layout) {
        layoutFile = layout.toString().replaceAll('{{ body }}', convertor);
        File('build/$safeName.html').writeAsString(layoutFile);
      });
    });
  });
  Directory('static/css/').list().listen((FileSystemEntity contents) {
    cssSafe = contents.path.replaceAll('static/css/', '');
    File(contents.path).readAsString().then((String cssContents) {
      File('build/css/$cssSafe').writeAsString(cssContents);
    });
  });
  print('Build done ! Check the build folder');
}