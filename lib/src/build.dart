import 'dart:io';
import 'package:markdown/markdown.dart';

/// The md to html convertor string result
String convertor;
/// The final html result
String layoutFile;

/// Buildfiles function
void buildFiles(File mdFile, File htmlFile) {
  mdFile.readAsString().then((String contents) {
    convertor = markdownToHtml(contents,
      inlineSyntaxes: <InlineHtmlSyntax>[InlineHtmlSyntax()]);
    File('static/layout.html').readAsString().then((String layout) {
      print(layout);
      layoutFile = layout.replaceAll('{{ body }}', convertor);
      htmlFile.writeAsString(layoutFile);
    });
  });
}
