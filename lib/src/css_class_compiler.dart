import 'dart:io';
import 'package:lenox/src/autoloader.dart';
import 'package:markdown/markdown.dart';

class CssClassCompiler {
  var config = LenoxContent();
  dynamic compile(markdown, theme) async {
    if (File('themes/$theme/$theme.yaml').existsSync()) {
      config.setConfig('themes/$theme/$theme.yaml');
      await config.getter();
      var data = config.getAll();
      var convertor = await markdownToHtml(markdown,
              inlineSyntaxes: <InlineHtmlSyntax>[InlineHtmlSyntax()])
          .replaceAll('#button', '<button>')
          .replaceAll('button#', '</button>');
      await data.forEach((key, value) =>
          convertor = convertor.replaceAll('<$key>', '<$key class="$value">'));
      return convertor;
    } else {
      var convertor = await markdownToHtml(markdown,
              inlineSyntaxes: <InlineHtmlSyntax>[InlineHtmlSyntax()])
          .replaceAll('#button', '<button>')
          .replaceAll('button#', '</button>');
      return convertor;
    }
  }
}
