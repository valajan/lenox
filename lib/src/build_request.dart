import 'dart:io';
import 'content.dart';
import 'package:http_server/http_server.dart';
import 'package:mime_type/mime_type.dart';
import 'package:mustache/mustache.dart';
import 'package:pedantic/pedantic.dart';

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
    var mimeType = 'text/html';
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
    if (mimeType != 'image/png' && mimeType != 'image/jpeg' && mimeType != 'image/x-icon') {
      await file.readAsString().then((contents) {
        response.write(contents);
        response.close();
      });
    } else {
      dir.serveFile(file, request);
    }
  }
}
