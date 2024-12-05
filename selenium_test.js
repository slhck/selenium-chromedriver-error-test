const chrome = require("selenium-webdriver/chrome");
const { spawnSync } = require("node:child_process");
const path = require("node:path");
const os = require("node:os");

const opts = new chrome.Options();

const profileDir = path.resolve(path.join(os.homedir(), "profile"));

opts.addArguments(
  "disable-gpu",
  "no-sandbox",
  "disable-setuid-sandbox",
  "disable-dev-shm-usage"
);

function getChromeDriverFromPath() {
  const result = spawnSync("which", ["chromedriver"]);
  if (result.status === 0) {
    return result.stdout.toString().trim();
  }
  return undefined;
}

// https://github.com/SeleniumHQ/selenium/issues/13181
// --> Selenium Manager will be ignored if driver is not undefined
const chromeDriverBinary = getChromeDriverFromPath();
const chromeDriverService = new chrome.ServiceBuilder(
  chromeDriverBinary
).build();

const driver = chrome.Driver.createSession(opts, chromeDriverService);

const main = async () => {
  // sleep for 1 second, then get all window handles
  await driver.sleep(1000);
  const windowHandles = await driver.getAllWindowHandles();
  console.log(windowHandles);
  // get URLs and titles for all windows
  for (const windowHandle of windowHandles) {
    await driver.switchTo().window(windowHandle);
    const url = await driver.getCurrentUrl();
    const title = await driver.getTitle();
    console.log({ url, title });
  }
  // navigate to google.com and quit
  await driver.get("https://www.google.com");
  await driver.quit();
};

main()
  .then(() => console.log("done"))
  .catch((e) => console.error(e));
