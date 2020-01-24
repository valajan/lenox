import 'dart:io';
import 'package:markdown/markdown.dart';

class CompileMdToHtml {
  void main(theme) {
    Directory('views').list().listen((FileSystemEntity contents) {
      var safeName =
          contents.uri.path.replaceAll('views/', '').replaceAll('.md', '');
      File('${contents.path}').readAsString().then((String contents) {
        var convertor = markdownToHtml(contents,
            inlineSyntaxes: <InlineHtmlSyntax>[InlineHtmlSyntax()],
            extensionSet: ExtensionSet.gitHubWeb);
        File('themes/$theme/layout.html').readAsString().then((String layout) {
          var layoutFile = layout.toString().replaceAll('{{ body }}', convertor);
          File('build/$safeName.html').writeAsString(layoutFile);
        });
      });
    });
  }
}
