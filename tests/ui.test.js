import assert from 'assert';
import { Builder, By, Key, until } from 'selenium-webdriver';

let driver = null;

beforeEach(function () {
  driver = new Builder().forBrowser('chrome').build();
  driver.get("http://127.0.0.1:4000");
});

afterEach(function () {
  driver.quit();
});

describe('User Interface', function () {
  it('should pass', function () {
    driver.findElement(By.css("button[data-name='about-me")).click();
  });
});