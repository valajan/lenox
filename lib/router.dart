// A faire : afficher un log error dans le naviguateur et la console quand
// le routeur ne dispose pas d'une configuration minimale à savoir :
// Une page d'erreur 404 à afficher par défaut
// Ou une page html associé à une url
// Rendre la configuration myConfig constante X  =>
// UPDATE : fait sur le fichier config.dart
// Ajout d'un markdown vers html convertisseur X =>
// UPDATE : fait grâce à la librairie markdown
// Choix du port par l'utilisateur X UPDATE: fait
// Corriger le mime type error de certains fichiers CSS
// Introduire les assets statiques

import 'dart:io';
import 'package:http_server/http_server.dart';
import 'package:markdown/markdown.dart';
import 'src/autoloader.dart';
// import 'src/build.dart';

/// Main class of the app
class Router {
  /// Router constructor
  Router({this.myView, this.errorPage, this.myPort}) {
    print('Thanks for using lenox static site gen!');
    myView == null ? myView = Directory('views') : myView = myView;
    errorPage == null
        ? errorPage = File('views/404.md')
        : errorPage = errorPage;
    myPort == null ? myPort = 3000 : myPort = myPort;
    myConfig == null ? myConfig = routeConfig : myConfig = myConfig;
  }

  /// View directory
  Directory myView;

  /// 404 error page
  File errorPage;

  /// Logger choice for the router
  bool logger;

  /// The route configuration
  Map<String, String> myConfig;

  /// Layout or template file
  File layout = File('static/layout.html');

  /// File to show for a specific route
  String myFile;

  /// Uri route
  String myRoute;

  /// Port for the server
  int myPort;

  /// Server variable
  HttpServer server;

  /// Config route keys
  List<String> sortedKeys;

  /// Config route values
  List<String> sortedValues;

  /// Markdown to html result
  String convertor;

  /// Final html result
  String layoutFinal;
  String myStaticFile;

  var builder = BuildRequest();

  /// Entry function
  Future<void> router({bool logger, String theme}) async {
    // If no theme is provided the default theme is blank
    theme ??= 'blank';
    var staticFiles = VirtualDirectory('static');
    staticFiles.jailRoot = false;
    staticFiles.allowDirectoryListing = true;
    staticFiles.followLinks = true;
    server = await HttpServer.bind(InternetAddress.loopbackIPv6, myPort);
    print('Open http://localhost:${server.port} to see your site');
    print('Press CTRL+C to stop');

    await server.listen((request) async {
      if (logger == true) print('${request.method} ${request.uri.path}');

      sortedKeys = myConfig.keys.toList();
      sortedValues = myConfig.values.toList();

      if (request.uri.path.contains('.css') ||
          request.uri.path.contains('.js') ||
          request.uri.path.contains('.ico')) {
        myRoute = request.uri.path;
      } else {
        myRoute = request.uri.path == '/' ? '/index.html' : request.uri.path;
      }

      myStaticFile = 'themes/$theme$myRoute';
      var safeStaticFile =
          myStaticFile.replaceAll('.html', '').replaceAll('themes/$theme/', '');
      myFile = '${myView.uri}/$safeStaticFile.md';

      if (File('$myFile').existsSync()) {
        await File('$myFile').readAsString().then((contents) {
          convertor = markdownToHtml(contents,
              inlineSyntaxes: <InlineHtmlSyntax>[InlineHtmlSyntax()],
              extensionSet: ExtensionSet.gitHubWeb);
        });
        builder.buildPage(myFile, request, convertor);
      } else if (File(myStaticFile).existsSync()) {
        builder.buildStaticFile(myStaticFile, request, staticFiles);
      } else {
        await File('views/404.md').readAsString().then((contents) {
          convertor = markdownToHtml(contents,
              inlineSyntaxes: <InlineHtmlSyntax>[InlineHtmlSyntax()],
              extensionSet: ExtensionSet.gitHubWeb);
        });
        builder.buildPage('views/404.md', request, convertor);
      }
    });
  }
}
