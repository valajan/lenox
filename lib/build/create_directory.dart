import 'dart:io';

class CreateDirectory {
  void main() {
    Directory('public').exists().then((bool result) {
      if (result == false) {
        print('Create the public directory');
        Directory('public').create();
      }
    });
    Directory('public/css').exists().then((bool result) {
      if (result == false) {
        print('Create the public/css directory');
        Directory('public/css').create();
      }
    });
    Directory('public/js').exists().then((bool result) {
      if (result == false) {
        print('Create the public/js directory');
        Directory('public/js').create();
      }
    });
    Directory('public/assets').exists().then((bool result) {
      if (result == false) {
        print('Create the public/assets directory');
        Directory('public/assets').create();
      }
    });
  }
}
