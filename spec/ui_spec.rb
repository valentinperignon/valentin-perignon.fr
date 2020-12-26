require "selenium-webdriver"

driver = nil

RSpec.describe("UI") do
  def click_ext_link(driver, num)
    
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

    driver.sleep(500)
    links.length.times do |n|

    end
  end
end