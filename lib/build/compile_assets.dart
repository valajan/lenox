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
    Directory('themes/$theme/assets/').list().listen((FileSystemEntity contents) {
      assetSafe = contents.path.replaceAll('themes/$theme/assets/', '');
      File(contents.path).copy('build/assets/$assetSafe');
    });
  }
}