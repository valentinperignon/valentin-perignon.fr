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
    await changeTab(tabNum);
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
    const urlRes = await checkUrl(links[i]);
    urlRes.should.equal(true);
    await webdriver.navigate().back();
  }
});

it("checks the links on the Project tab", async function () {
  this.timeout(10e5);

  const links = ["schoolexams", "github", "codepen"];
  await changeTab(1);
  const documentLinks = await webdriver.findElements(By.css(".display-content a"));
  documentLinks.length.should.equal(links.length);

  for (let i = 0; i < links.length; i++) {
    const all = await webdriver.findElements(By.css(".display-content a"));
    await all[i].click();
    const urlRes = await checkUrl(links[i]);
    urlRes.should.equal(true);
    await webdriver.navigate().back();
    await changeTab(1);
  }
});

afterEach(async function () {
  await webdriver.quit();
});

/* ---------- Functions ---------- */

async function clickExtLink(num) {
  await webdriver.findElement(By.css(`header > #title > ul > li:nth-of-type(${num+1}) > a`)).click();
}

async function checkUrl(expected) {
  const url = await webdriver.getCurrentUrl();
  return new RegExp(expected).test(url);
}

async function getCurrentTab() {
  return await webdriver.findElement(By.css("button.selected")).getText();
}

async function changeTab(num) {
  await webdriver.findElement(By.css(`main > nav li:nth-of-type(${num+1}) > button`)).click();
}