REM
REM Set the two paths below to a normal and msys2 version of Git on Windows.
REM

REM Things go wrong if we call any msys program (for example git).
C:\Dev\Tools\msys64\usr\bin\cal.exe

REM Things go wrong when the spawned process is Dart, but not when it is nodejs
"dart.exe" "fake_daemon.dart"
REM "node" "fake_daemon.js"

