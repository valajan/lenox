import 'package:http_server/http_server.dart';

class StaticDirectory {
  VirtualDirectory staticDirectory;

  void main() {
    staticDirectory = VirtualDirectory('themes');
    staticDirectory.jailRoot = false;
    staticDirectory.allowDirectoryListing = true;
    staticDirectory.followLinks = true;
  }

  VirtualDirectory getStaticDirectory() {
    main();
    return staticDirectory;
  }
}