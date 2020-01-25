import 'dart:io';
import 'package:http_server/http_server.dart';
import 'package:mime_type/mime_type.dart';
import 'package:lenox_content/lenox_content.dart';

class BuildRequest {
  String layoutFinal;
  String title;
  String author;
  String description;
  String keywords;
  String language;
  String subtitle;
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
  }

  void buildPage(
      String fileName, HttpRequest request, String layout, String theme) async {
    await configContent();
    var response = request.response;
    var mimeType = 'text/html';
    response.headers.set('Content-Type', mimeType);
    await File('themes/$theme/layout.html').readAsString().then((contents) {
      layoutFinal = contents.toString()
        .replaceAll('{{ body }}', layout)
        .replaceAll('{{ title }}', title)
        .replaceAll('{{ description }}', description)
        .replaceAll('{{ keywords }}', keywords)
        .replaceAll('{{ author }}', author)
        .replaceAll('{{ language }}', language);
      response.write(layoutFinal);
      response.close();
    });
  }

  void buildStaticFile(
      String fileName, HttpRequest request, VirtualDirectory dir) async {
    var response = request.response;
    var file = File(fileName);
    var mimeType = mime(fileName);
    mimeType ??= 'text/plain; charset=UTF-8';
    response.headers.set('Content-Type', mimeType);
    if (mimeType != 'image/png' && mimeType != 'image/jpeg') {
      await file.readAsString().then((contents) {
        response.write(contents);
        response.close();
      });
    } else {
      dir.serveFile(file, request);
    }
  }
}
