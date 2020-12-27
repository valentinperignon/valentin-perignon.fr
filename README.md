# My personal website

My personal website, built with [Jekyll](https://jekyllrb.com/).

![Website](https://img.shields.io/website?up_message=online&url=https%3A%2F%2Fwww.valentin-perignon.fr)

## Getting Started
### Prerequisites

 - [Ruby](https://www.ruby-lang.org/en/)
 - [RubyGems](https://rubygems.org/)
 - [Bundler](https://bundler.io/)

### Installation

You can install all necessary dependencies with Bundler.
```
bundle install
```
It will install:
 - [Jekyll](https://jekyllrb.com/)
 - [RSpec](https://rspec.info/)
 - [Selenium WebDriver](https://www.selenium.dev/)

## Build

The site will be built into a `_site` directory.
```
bundle exec jekyll build
```

## Running the tests
To run the tests, you need to download the [Selenium chromedriver](https://www.selenium.dev/documentation/en/webdriver/driver_requirements/). Then just run the following command:
```
bundle exec rspec spec/ui_spec.rb
```
