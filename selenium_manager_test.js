const { Builder, Browser, Capabilities } = require("selenium-webdriver");
const chrome = require("selenium-webdriver/chrome");

const opts = new chrome.Options().addArguments(
  "disable-gpu",
  "no-sandbox",
  "disable-setuid-sandbox",
  "disable-dev-shm-usage"
);

const capabilities = new Capabilities()
  .setBrowserName(Browser.CHROME)
  // .setBrowserVersion("131.0.6778.85");
  .setBrowserVersion("130.0.6723.91");

const main = async () => {
  const driver = await new Builder()
    .forBrowser(Browser.CHROME)
    .withCapabilities(capabilities)
    .build();
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
