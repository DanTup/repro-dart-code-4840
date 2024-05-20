const child_process = require("child_process")

async function main() {
	const process = child_process.spawn("fake_flutter.bat", [], { shell: true });

	await new Promise((resolve) => {
		process.stdout.on("data", (data) => { resolve(); console.log(`    <== ${data}`); });
		process.stderr.on("data", (data) => { resolve(); console.log(`        <== ERROR == ${data}`); });
		process.on("exit", (code, signal) => console.log(`exit: ${code}, ${signal}`));
		process.on("error", (data) => console.log(`        <== ERROR! == ${data}`));
	})

	function send(msg) {
		console.log(`==> ${msg}`);
		process.stdin.write(`${msg}\n`);
	}

	for (var i = 1; i < 1000; i++) {
		send(`Hello!`);
		await new Promise((resolve) => setTimeout(resolve, 1000));
	}

	console.log('Finishing!');
	process.kill();
}

main();
