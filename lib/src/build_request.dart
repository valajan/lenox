import 'dart:io';
import 'content.dart';
import 'package:http_server/http_server.dart';
import 'package:mime_type/mime_type.dart';
import 'package:mustache/mustache.dart';
import 'package:pedantic/pedantic.dart';
import 'package:front_matter/front_matter.dart' as fm;

class BuildRequest {

  String layoutFinal;

  String title;

  String author;

  String description;

  String keywords;

  String language;

  String subtitle;

  String theme;

  String source;

  Template template;

  String output;

  var config = LenoxContent();

  void configContent() async {
    config.setConfig('config/config.yaml');
    await config.getter();
    title = config.getTitle();
    author = config.getAuthor();
    description = config.getDescription();
    keywords = config.getKeywords();
    language = config.getLanguage();
    subtitle = config.getSubtitle();
    theme = config.getTheme();
  }

  void buildPage(String fileName, HttpRequest request, String layout) async {
    await configContent();
    var file = File(fileName);
    var fileContent = await file.readAsString();
    var doc = fm.parse(fileContent);
    if (doc.data != null) {
      if (doc.data['title'] != null) title = doc.data['title'];
      if (doc.data['subtitle'] != null) subtitle = doc.data['subtitle'];
      if (doc.data['description'] != null) description = doc.data['description'];
      if (doc.data['keywords'] != null) keywords = doc.data['keywords'];
    }
    await File('themes/$theme/layout.html').readAsString().then((contents) {
      source = contents;
    });
    template = Template(source, name: 'themes/$theme/layout.html');
    output = template.renderString({
      'author': author,
      'body': layout,
      'description': description,
      'keywords': keywords,
      'language': language,
      'title': title
    });
    var response = request.response;
    var mimeType = 'text/html; charset=UTF-8';
    response.headers.set('Content-Type', mimeType);
    response.write(output);
    unawaited(response.close());
  }

  void buildStaticFile(
      String fileName, HttpRequest request, VirtualDirectory dir) async {
    var response = request.response;
    var file = File(fileName);
    var mimeType = mime(fileName);
    mimeType ??= 'text/plain; charset=UTF-8';
    response.headers.set('Content-Type', mimeType);
    if (mimeType.contains('image/') || mimeType.contains('video/')) {
      dir.serveFile(file, request);
    } else {
        await file.readAsString().then((contents) {
        response.write(contents);
        response.close();
      });
    }
  }
}
