import 'dart:io';
import 'package:process_run/process_run.dart';

class CompileDartToJs {
  void main(verbose, theme) {
    if (verbose) {
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
