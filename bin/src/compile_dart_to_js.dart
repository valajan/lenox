import 'dart:io';
import 'package:lenox/src/autoloader.dart';
import 'package:process_run/process_run.dart';

class CompileDartToJs {
  String theme;
  LenoxContent config = LenoxContent();
  void main(verbose) async {
    if (verbose) {
      config.setConfig('config/config.yaml');
      await config.getter();
      theme = config.getTheme();
      Directory('themes/$theme/js').list().listen((FileSystemEntity contents) {
        var safeName =
            contents.uri.path.replaceAll('themes/$theme/js/', '').replaceAll('.dart', '');
        if (safeName.contains('.js') != true) {
          Directory('build/js/').create();
          print('Compile dart file to js');
          run('dart2js ${contents.uri.path} -O2 -o build/js/$safeName.js', [''], verbose: true);
        }
      });
    }
  }
}
