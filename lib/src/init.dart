import 'package:process_run/process_run.dart';

class Init {
  void main() async {
    print('Cloning the repo...');
    await run('git clone https://github.com/valajan/lenox_content.git', [''], verbose: true);
  }
}
