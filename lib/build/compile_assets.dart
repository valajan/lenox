import 'dart:io';
import 'package:lenox/src/autoloader.dart';

class CompileAssets {
  String assetSafe;
  String theme;
  LenoxContent config = LenoxContent();
  void main() async {
    config.setConfig('config.yaml');
    await config.getter();
    theme = config.getTheme();
    if (Directory('themes/$theme/assets/').existsSync()) {
      Directory('themes/$theme/assets/')
          .list()
          .listen((FileSystemEntity contents) {
        print(contents);
        assetSafe = contents.path.replaceAll('themes/$theme/assets/', '');
        File(contents.path).copy('public/assets/$assetSafe');
      });
    }
  }
}
