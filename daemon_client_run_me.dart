import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final proc = await Process.start('fake_flutter.bat', []);
  proc.stdout
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .listen((s) => print('    <== $s'));
  proc.stderr
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .listen((s) => print('        <== ERROR == $s'));

  void send(String msg) {
    print('==> $msg');
    proc.stdin.writeln(msg);
  }

  for (int i = 1; i < 1000; i++) {
    send('Hello!');
    await Future.delayed(const Duration(seconds: 1));
  }

  print('Finishing!');
  proc.kill();
}
