require "selenium-webdriver"
require "net/http"

$driver = nil
$wait = nil
$links_tested = []

RSpec.describe "User Interface" do
  # Functions

  def check_url(expected)
    current_url = $driver.current_url

    res = true
    if !$links_tested.include?(current_url)
      uri = URI.parse current_url
      res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == "https") do |http|
        req = Net::HTTP::Get.new uri
        result = http.request req
        result.code != "404"
      end
      $links_tested.push(current_url)
    end

    current_url =~ /#{expected}/ && res
  end

  def click_ext_link(num)
    $driver.find_element(:css, "header > #title > ul > li:nth-of-type(#{num+1}) > a").click
  end

  def get_current_tab
    $driver.find_element(:css, "button.selected").text
  end

  def change_tab(num)
    $driver.find_element(:css, "main > nav li:nth-of-type(#{num+1}) > button").click
  end

  # Before and after

  before(:each) do
    $driver = Selenium::WebDriver.for :chrome
    $driver.get "http://127.0.0.1:4000"
    $wait = Selenium::WebDriver::Wait.new :timeout => 10
  end

  after(:each) do
    $driver.quit
  end

  # Tests

  it "checks the three tabs" do
    # check default tab
    first_tab = $driver.find_element(:css, "main > nav li:first-of-type > button").text
    default_tab = get_current_tab
    expect(first_tab).to eq(default_tab)

    # navigate between tabs
    next_tab = default_tab
    [1, 2, 0].each do |n|
      change_tab n
      tmp = get_current_tab
      expect(next_tab).to_not eq(tmp)
      next_tab = tmp
    end
  end

  it "checks the external links in the header" do
    links = ["resume.pdf", "linkedin.com", "github.com", "codepen.io"]
    links.length.times do |n|
      $wait.until do $driver.find_element(:css, "header > #title > ul > li:nth-of-type(1) > a") end
      click_ext_link n
      expect(check_url(links[n])).to eq(true)
      $driver.navigate.back
    end
  end

  it "checks the links on the Project tab" do
    links = ["schoolexams", "pang", "github", "codepen"]
    change_tab 1
    documentLinks = $driver.find_elements(:css, ".display-content a")
    expect(links.length).to eq(documentLinks.length)

    links.length.times do |n|
      all = $driver.find_elements(:css, ".display-content a")
      all[n].click
      expect(check_url(links[n])).to eq(true)
      $driver.navigate.back
      change_tab 1
    end
  end
end