import 'dart:io';
import 'package:lenox/src/autoloader.dart';
import 'package:mustache/mustache.dart';
import 'package:lenox/src/css_class_compiler.dart';
import 'package:front_matter/front_matter.dart' as fm;

class CompileMdToHtml {
  String title;

  String author;

  String description;

  String keywords;

  String language;

  String subtitle;

  String theme;

  LenoxContent config = LenoxContent();

  CssClassCompiler compiler = CssClassCompiler();

  String source;

  Template template;

  String convertor;

  void configContent() async {
    config.setConfig('config/config.yaml');
    await config.getter();
    author = config.getAuthor();
    title = config.getTitle();
    description = config.getDescription();
    keywords = config.getKeywords();
    language = config.getLanguage();
    subtitle = config.getSubtitle();
    theme = config.getTheme();
  }

  void main() async {
    await configContent();
    Directory('pages').list().listen((FileSystemEntity contents) async {
      var file = File(contents.uri.path);
      var fileContent = await file.readAsString();
      var doc = fm.parse(fileContent);
      await File('themes/$theme/layout.html')
          .readAsString()
          .then((String layout) {
        source = layout;
      });
      if (doc.content != null) {
        convertor = await compiler.compile(doc.content, theme);
      } else {
        convertor = await compiler.compile(doc.toString(), theme);
      }
      if (doc.data != null) {
        if (doc.data['title'] != null) title = doc.data['title'];
        if (doc.data['subtitle'] != null) subtitle = doc.data['subtitle'];
        if (doc.data['description'] != null) description = doc.data['description'];
        if (doc.data['keywords'] != null) keywords = doc.data['keywords'];
      }
      template = Template(source, name: 'themes/$theme/layout.html');
      var output = template.renderString({
        'author': author,
        'body': convertor,
        'description': description,
        'keywords': keywords,
        'language': language,
        'title': title
      });
      var safeName =
          contents.uri.path.replaceAll('pages/', '').replaceAll('.md', '');
      if (safeName == 'index') {
        File('build/$safeName.html').writeAsStringSync(output);
      } else {
        await Directory('build/$safeName').create();
        File('build/$safeName/index.html').writeAsStringSync(output);
      }
    });
  }
}
