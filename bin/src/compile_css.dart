import 'dart:io';

class CompileCss {
  String cssSafe;
  void main(theme) {
    Directory('themes/$theme/css/').list().listen((FileSystemEntity contents) {
      cssSafe = contents.path.replaceAll('themes/$theme/css/', '');
      File(contents.path).readAsString().then((String cssContents) {
        File('build/css/$cssSafe').writeAsString(cssContents);
        print('Build done ! Check the build folder');
      });
    });
  }
}
