import 'dart:io';
import 'package:lenox/src/autoloader.dart';
import 'package:markdown/markdown.dart';
import 'package:mustache/mustache.dart';

class CompileMdToHtml {
  String title;

  String author;

  String description;

  String keywords;

  String language;

  String subtitle;

  String theme;

  Template template;

  var config = LenoxContent();

  void configContent() async {
    config.setConfig('config/config.yaml');
    await config.getter();
    title = config.getTitle();
    description = config.getDescription();
    keywords = config.getKeywords();
    language = config.getLanguage();
    subtitle = config.getSubtitle();
    theme = config.getTheme();
  }

  void main() async {
    await configContent();
    Directory('views').list().listen((FileSystemEntity contents) {
      var safeName =
          contents.uri.path.replaceAll('views/', '').replaceAll('.md', '');
      File('${contents.path}').readAsString().then((String contents) {
        var convertor = markdownToHtml(contents,
            inlineSyntaxes: <InlineHtmlSyntax>[InlineHtmlSyntax()],
            extensionSet: ExtensionSet.gitHubWeb).replaceAll('#button', '<button>').replaceAll('button#', '</button>');
        File('themes/$theme/layout.html').readAsString().then((String layout) {
          // var layoutFile =
          //     layout.toString().replaceAll('{{ body }}', convertor);
          var source = layout;
          template = Template(source, name: 'themes/$theme/layout.html');
          var output = template.renderString({
            'author': author,
            'body': convertor,
            'description': description,
            'keywords': keywords,
            'language': language,
            'title': title
          });
          File('build/$safeName.html').writeAsString(output);
          // File('build/$safeName.html').writeAsString(layoutFile);
        });
      });
    });
  }
}
