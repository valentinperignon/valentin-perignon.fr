import chai from "chai";
import { Builder, By } from "selenium-webdriver";

chai.should();

let webdriver = null;

beforeEach(async function () {
  webdriver = await new Builder().forBrowser('chrome').build();
  await webdriver.get("http://127.0.0.1:4000");
});

it("checks the three tabs", async function () {
  this.timeout(10e5);
  // Check default tab
  const firstTab = await webdriver.findElement(By.css("main > nav li:first-of-type > button")).getText();
  const defaultTab = await getCurrentTab();
  defaultTab.should.equal(firstTab);

  // Navigate between tabs
  let nextTab = defaultTab;
  for (let tabNum of [1, 2, 0]) {
    await clickTab(tabNum);
    let tmp = await getCurrentTab();
    nextTab.should.not.equal(tmp);
    nextTab = tmp;
  }
});

it("checks the external links in the header", async function () {
  this.timeout(10e5);
  const links = ["resume", "linkedin", "github", "codepen"];

  for (let i = 0; i < links.length; i++) {
    await clickExtLink(i);
    const url = await webdriver.getCurrentUrl();
    const res = new RegExp(links[i]).test(url);
    res.should.equal(true);
    await webdriver.navigate().back();
  }
});

afterEach(async function () {
  await webdriver.quit();
});

/* ---------- Functions ---------- */

async function clickExtLink(num) {
  await webdriver.findElement(By.css(`header > #title > ul > li:nth-of-type(${num+1}) > a`)).click();
}

async function getCurrentTab() {
  return await webdriver.findElement(By.css("button.selected")).getText();
}

async function clickTab(num) {
  await webdriver.findElement(By.css(`main > nav li:nth-of-type(${num+1}) > button`)).click();
}