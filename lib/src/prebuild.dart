import 'dart:io';
import 'autoloader.dart';
import 'package:process_run/cmd_run.dart';

class Prebuild {
  void main() async {
    var config = LenoxContent();
    config.setConfig('config/config.yaml');
    await config.getter();
    var theme = config.getTheme();
    Directory('themes/$theme/js').list().listen((FileSystemEntity contents) {
      var safeName = contents.uri.path
          .replaceAll('themes/$theme/js', '')
          .replaceAll('.dart', '');
      if (safeName.contains('.js') != true) {
        print('Compile dart files');
        run('dart2js ${contents.uri.path} -O2 -o themes/$theme/js/$safeName.js',
            [''],
            verbose: false);
      }
    });
  }
}
