import 'dart:io';
import 'package:lenox/src/autoloader.dart';

class CompileCss {
  String cssSafe;
  String theme;
  LenoxContent config = LenoxContent();
  void main() async {
    config.setConfig('config/config.yaml');
    await config.getter();
    theme = config.getTheme();
    print(theme);
    Directory('themes/$theme/css/').list().listen((FileSystemEntity contents) {
      cssSafe = contents.path.replaceAll('themes/$theme/css/', '');
      File(contents.path).readAsString().then((String cssContents) {
        File('build/css/$cssSafe').writeAsString(cssContents);
        print('Build done ! Check the build folder');
      });
    });
  }
}
