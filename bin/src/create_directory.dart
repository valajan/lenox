import 'dart:io';

class CreateDirectory {
  void main() {
    Directory('build').exists().then((bool result) {
      if (result == false) {
        print('Create the build directory');
        Directory('build').create();
      }
    });
    Directory('build/css').exists().then((bool result) {
      if (result == false) {
        print('Create the build/css directory');
        Directory('build/css').create();
      }
    });
    Directory('build/js').exists().then((bool result) {
      if (result == false) {
        print('Create the build/js directory');
        Directory('build/js').create();
      }
    });
  }
}
