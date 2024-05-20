import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  print('Flutter Daemon started!');
  stdin.transform(utf8.decoder).listen(
    (input) {
      print('Daemon was sent: $input');
    },
    onDone: () {
      print('Stream done! WERE YOU EXPECTING THIS?');
    },
    onError: (e, s) {
      print('ERROR! $e\n$s');
    },
  );

  // Keep the process alive (see additional notes in readme).
  await Future.delayed(const Duration(hours: 1));
}
