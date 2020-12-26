require "selenium-webdriver"

driver = nil
wait = nil

RSpec.describe("User Interface") do
  def check_url(driver, expected)
    driver.current_url =~ /#{expected}/
  end

  def click_ext_link(driver, num)
    driver.find_element(:css, "header > #title > ul > li:nth-of-type(#{num+1}) > a").click
  end

  def get_current_tab(driver)
    driver.find_element(:css, "button.selected").text
  end

  def change_tab(driver, num)
    driver.find_element(:css, "main > nav li:nth-of-type(#{num+1}) > button").click
  end

  before(:each) do
    driver = Selenium::WebDriver.for(:chrome)
    driver.get("http://127.0.0.1:4000")
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  after(:each) do
    driver.quit
  end

  it("checks the three tabs") do
    # check default tab
    first_tab = driver.find_element(:css, "main > nav li:first-of-type > button").text
    default_tab = get_current_tab(driver)
    expect(first_tab).to(eq(default_tab))

    # navigate between tabs
    next_tab = default_tab
    [1, 2, 0].each do |tab|
      change_tab(driver, tab)
      tmp = get_current_tab(driver)
      expect(next_tab).to_not(eq(tmp))
      next_tab = tmp
    end
  end

  it("checks the external links in the header") do
    links = ["resume.pdf", "linkedin.com", "github.com", "codepen.io"]
    links.length.times do |n|
      wait.until do driver.find_element(:css, "header > #title > ul > li:nth-of-type(1) > a") end
      click_ext_link(driver, n)
      expect(check_url(driver, links[n])).to_not(eq(nil))
      driver.navigate.back
    end
  end

  it("checks the links on the Project tab") do
    links = ["schoolexams", "github", "codepen"]
    change_tab(driver, 1)
    documentLinks = driver.find_elements(:css, ".display-content a")
    expect(links.length).to(eq(documentLinks.length))

    links.length.times do |n|
      all = driver.find_elements(:css, ".display-content a")
      all[n].click
      expect(check_url(driver, links[n])).to_not(eq(nil))
      driver.navigate.back
      change_tab(driver, 1)
    end
  end
end