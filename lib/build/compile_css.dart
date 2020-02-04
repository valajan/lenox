import 'dart:io';
import 'package:lenox/src/autoloader.dart';

class CompileCss {
  String cssSafe;
  String theme;
  LenoxContent config = LenoxContent();
  void main() async {
    config.setConfig('config.yaml');
    await config.getter();
    theme = config.getTheme();
    Directory('themes/$theme/css/').list().listen((FileSystemEntity contents) {
      print(contents);
      cssSafe = contents.path.replaceAll('themes/$theme/css/', '');
      File(contents.path).copy('build/css/$cssSafe');
    });
    print('Build done ! Check the build folder');
  }
}
