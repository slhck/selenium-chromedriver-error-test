# Docker Selenium Error Case

Reproduction under macOS 14.7 (23H124) on Apple Silicon with Docker Desktop 4.36.0.

selenium-webdriver@4.27.0 and chrome@131.0.6778.85.

Run:

```
./build.sh
```

Then in the console you see:

```
seleniumtest@e6bd235db324:~$ DISPLAY=:123 NODE_PATH=/usr/lib/node_modules node selenium_test.js
WebDriverError: disconnected: Unable to receive message from renderer
  (failed to check if window was closed: disconnected: not connected to DevTools)
  (Session info: chrome=131.0.6778.85)
    at Object.throwDecodedError (/usr/lib/node_modules/selenium-webdriver/lib/error.js:521:15)
    at parseHttpResponse (/usr/lib/node_modules/selenium-webdriver/lib/http.js:514:13)
    at Executor.execute (/usr/lib/node_modules/selenium-webdriver/lib/http.js:446:28)
    at process.processTicksAndRejections (node:internal/process/task_queues:95:5) {
  remoteStacktrace: '#0 0xaaaab6edcec0 <unknown>\n' +
    '#1 0xaaaab6a54ef0 <unknown>\n' +
    '#2 0xaaaab6a426f8 <unknown>\n' +
    '#3 0xaaaab6a42544 <unknown>\n' +
    '#4 0xaaaab6a4079c <unknown>\n' +
    '#5 0xaaaab6a40a88 <unknown>\n' +
    '#6 0xaaaab6a479c4 <unknown>\n' +
    '#7 0xaaaab6a3f6c4 <unknown>\n' +
    '#8 0xaaaab6a4222c <unknown>\n' +
    '#9 0xaaaab6a4079c <unknown>\n' +
    '#10 0xaaaab6a40a88 <unknown>\n' +
    '#11 0xaaaab6a38c14 <unknown>\n' +
    '#12 0xaaaab6a3f6c4 <unknown>\n' +
    '#13 0xaaaab6a3f1e8 <unknown>\n' +
    '#14 0xaaaab6a3ee28 <unknown>\n' +
    '#15 0xaaaab6a5771c <unknown>\n' +
    '#16 0xaaaab6a332b4 <unknown>\n' +
    '#17 0xaaaab6a32b20 <unknown>\n' +
    '#18 0xaaaab6ac8ba0 <unknown>\n' +
    '#19 0xaaaab6ac8360 <unknown>\n' +
    '#20 0xaaaab6a8dde0 <unknown>\n' +
    '#21 0xaaaab6a8eaf8 <unknown>\n' +
    '#22 0xaaaab6eb0b6c <unknown>\n' +
    '#23 0xaaaab6eb3b38 <unknown>\n' +
    '#24 0xaaaab6eb3704 <unknown>\n' +
    '#25 0xaaaab6ea2840 <unknown>\n' +
    '#26 0xaaaab6eb4170 <unknown>\n' +
    '#27 0xaaaab6e8d580 <unknown>\n' +
    '#28 0xaaaab6ecc5f8 <unknown>\n' +
    '#29 0xaaaab6ecc7e0 <unknown>\n' +
    '#30 0xaaaab6edbe8c <unknown>\n' +
    '#31 0xffffbbddee8c <unknown>\n' +
    '#32 0xffffbbe47b18 <unknown>\n'
}
```

I can't get Selenium Manager to work:

```
DISPLAY=:123 NODE_PATH=/usr/lib/node_modules node selenium_manager_test.js
Error: Server was killed with SIGTRAP
    at /usr/lib/node_modules/selenium-webdriver/remote/index.js:256:70
    at process.processTicksAndRejections (node:internal/process/task_queues:95:5)
```
