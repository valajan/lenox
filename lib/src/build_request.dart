import 'dart:io';
import 'package:http_server/http_server.dart';
import 'package:mime_type/mime_type.dart';

class BuildRequest {

  String layoutFinal;

  void buildPage(String fileName, HttpRequest request, String layout) async {
    HttpResponse response = request.response;
    String mimeType = 'text/html';
    response.headers.set('Content-Type', mimeType);
    await File('static/layout.html').readAsString().then((contents) {
      layoutFinal = contents.toString().replaceAll('{{ body }}', layout);
      response.write(layoutFinal);
      response.close();
    });
  }

  void buildStaticFile(
      String fileName, HttpRequest request, VirtualDirectory dir) async {
    HttpResponse response = request.response;
    File file = new File(fileName);
    String mimeType = mime(fileName);
    if (mimeType == null) mimeType = 'text/plain; charset=UTF-8';
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
