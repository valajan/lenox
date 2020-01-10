import 'dart:io';
import 'package:markdown/markdown.dart';

void buildFiles(mdFile, htmlFile) {
  mdFile.readAsString().then((contents) {
    var convertor = markdownToHtml(contents,
      inlineSyntaxes: [new InlineHtmlSyntax()]);
    File('static/layout.html').readAsString().then((layout) {
      print(layout);
      var layoutFile = layout.replaceAll('{{ body }}', convertor);
      htmlFile.writeAsString(layoutFile);
    });
  });
}