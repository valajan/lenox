// A faire : afficher un log error dans le naviguateur et la console quand
// le routeur ne dispose pas d'une configuration minimale à savoir :
// Une page d'erreur 404 à afficher par défaut
// Ou une page html associé à une url
// Rendre la configuration myConfig constante X UPDATE : fait sur le fichier config.dart
// Ajout d'un markdown vers html convertisseur X UPDATE : fait grâce à la librairie markdown
// Choix du port par l'utilisateur X UPDATE: fait
// Corriger le mime type error de certains fichiers CSS
// Introduire les assets statiques

import 'dart:io';
import 'package:markdown/markdown.dart';
import 'src/build.dart';

class Router {
  Directory myView;
  File errorPage;
  bool logger;
  String params_uri;
  String params_file;
  Map myConfig;
  File layout = File('static/layout.html');
  File myFile;
  String myRoute;
  int myPort;

  Router([this.myView, this.errorPage, this.myPort]) {
    print('Thanks for using lenox static site gen!');
    this.myView == null ? this.myView = Directory('views') : this.myView = this.myView;
    this.errorPage == null ? this.errorPage = File('views/404.md') : this.errorPage = this.errorPage;
    this.myPort == null ? this.myPort = 3000 : this.myPort = this.myPort;
  }

  Future router([logger = false]) async {
    var server = await HttpServer.bind(InternetAddress.loopbackIPv6, myPort);
    print('Open http://localhost:${server.port} to see your site');
    print('Press CTRL+C to stop');

    await for (HttpRequest request in server) {
      logger == true ? print('${request.method} ${request.uri.path}') : '';
      var i;
      var sortedKeys = myConfig.keys.toList();
      var sortedValues = myConfig.values.toList();
      request.uri.path == '/' ? myRoute = '/index' : myRoute = request.uri.path;
      myFile = File('${myView.uri}/${myRoute}.md');
      if (myConfig.containsKey(request.uri.path)) {
        for (i = 0; i < sortedKeys.length; i++) {
          if (sortedKeys[i] == request.uri.path) {
            myFile = File('${myView.uri}/${sortedValues[i]}.md');
            buildHtmlFile(myFile, request);
            continue;
          } else {
            continue;
          }
        }
      } else if (myFile.existsSync()) {
        buildHtmlFile(myFile, request);
        continue;
      } else {
        buildHtmlFile(errorPage, request);
      }
    }
  }

  void config(config) {
    this.myConfig = config;
  }

  void buildHtmlFile(file, request) {
    file.readAsString().then((contents) {
      request.response.headers.contentType = ContentType.html;
      /// Prototype de syntaxe markdown customisable
      // var newContent = contents.toString().replaceAll('[button]', '<button class="btn btn-primary">').replaceAll('[/button]', '</button>');
      // print(newContent);
      var convertor = markdownToHtml(contents,
        inlineSyntaxes: [new InlineHtmlSyntax()]);
      layout.readAsString().then((layoutContent) {
        var layoutFinal = layoutContent.toString().replaceAll('{{ body }}', convertor);
        request.response.write(layoutFinal);
        request.response.close();
      });
    });
  }

  // Utilisr bin/build.dart ou lib/build.dart
  void build() {
    Directory('views').list().listen((contents) {
      var safe1 = contents.uri.path.replaceAll('views/', '');
      var safe2 = safe1.replaceAll('.md', '');
      buildFiles(File('${contents.path}'), File('${myView.uri}/$safe2.html'));
    });
  }
  
}
