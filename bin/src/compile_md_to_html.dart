import 'dart:io';
import 'package:lenox/src/autoloader.dart';
import 'package:mustache/mustache.dart';
import 'package:lenox/src/css_class_compiler.dart';

class CompileMdToHtml {
  String title;

  String author;

  String description;

  String keywords;

  String language;

  String subtitle;

  String theme;

  Template template;

  LenoxContent config = LenoxContent();

  CssClassCompiler compiler = CssClassCompiler();

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
      File('${contents.path}').readAsString().then((String contents) async {
        var convertor = await compiler.compile(contents);
        await File('themes/$theme/layout.html').readAsString().then((String layout) {
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
        });
      });
    });
  }
}
