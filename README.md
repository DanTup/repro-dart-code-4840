## Dart-Code 4840 / Flutter 143625 Repro

This reproduces the issue described in:

- https://github.com/Dart-Code/Dart-Code/issues/4840
- https://github.com/flutter/flutter/issues/143625

The issue appears to occur on Windows when the `git` in `PATH` is from
[msys2](https://www.msys2.org/). Although the call to git appears to work just
the same as a standard Windows Git, when the daemon is spawned, the stdin stream
closes almost immediately, and the daemon no longer gets any input sent from
the IDE.

- `daemon_client_run_me.js` - the entry script which plays the part of
  Dart-Code. It spawns the fake Flutter daemon and repeatedly sends messages to
  it.
- `daemon_client_run_me.dart` - a Dart version of the entry script which does
  not reproduce the issue (see additional notes below).
- `fake_flutter.bat` - the fake `flutter.bat` file which includes a call to
  `git` to check the revision of the Flutter SDK. The implementation here is
  simplified to just execute the command and not do anything with the result.
- `fake_daemon.dart` - the fake `flutter daemon` which just echos back and input
  it gets, and prints when the `stdin` stream closes.

### Running the Test:

1. Update the two paths in `fake_flutter.bat` to point at a normal Windows
   version of `git` and an `msys2` version of `git`. Leave the native Windows
   version uncommented.
2. Run `node ./daemon_client_run_me.js` from the current folder.
3. Observe that `"Stream done! WERE YOU EXPECTING THIS?"` is **NOT** printed and
   the daemon response to each "Hello" message.
4. Swap to the `msys2` version of `git` in `fake_flutter.bat`.
5. Run `node ./daemon_client_run_me.js` from the current folder.
6. Observe that `"Stream done! WERE YOU EXPECTING THIS?"` **IS** printed and the
   daemon no longer responds to each "Hello" message.

### Additional Notes:

- The issue only seems to occur with the node client
  (`daemon_client_run_me.js`). The equivalent Dart code
  (`daemon_client_run_me.dart`) does not seem to cause the issue.
- Removing the long wait at the end of `fake_daemon.dart` causes the process to
  exit in the failure case (with no errors), however in the case of the real
  Flutter daemon, the process does not exit (probably something else is keeping
  it alive).
- The issue is not `git`-specific. Running any command from `msys2` seems to
  trigger the issue (for example, using `msys64\usr\bin\cal.exe` in the `.bat`).
