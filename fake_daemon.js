console.log('Flutter Daemon started!');

process.stdin.on('data', function (input) {
  console.log(`Daemon was sent: ${input}`);
});

process.stdin.on('end', function () {
  console.log('Stream done! WERE YOU EXPECTING THIS?');
});

process.stdin.on('error', function (e) {
  console.log(`Error! ${e}`);
});
