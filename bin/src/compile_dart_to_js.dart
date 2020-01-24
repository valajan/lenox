import 'dart:io';
import 'package:process_run/process_run.dart';

class CompileDartToJs {
  void main(verbose) {
    if (verbose) {
      Directory('static/js').list().listen((FileSystemEntity contents) {
        var safeName =
            contents.uri.path.replaceAll('static/js/', '').replaceAll('.dart', '');
        if (safeName.contains('.js') != true) {
          Directory('build/js/$safeName').create();
          print('Compile dart file to js');
          run('dart2js ${contents.uri.path} -O2 -o build/js/$safeName/$safeName.js', [''], verbose: true);
        }
      });
    }
  }
}