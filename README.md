# My personal website

My personal website, built with [Jekyll](https://jekyllrb.com/).

![CircleCI](https://img.shields.io/circleci/build/github/valentinperignon/valentin-perignon.fr/main)
![Website](https://img.shields.io/website?up_message=online&url=https%3A%2F%2Fwww.valentin-perignon.fr)

## Getting Started
### Prerequisites

 - [Ruby](https://www.ruby-lang.org/en/)
 - [RubyGems](https://rubygems.org/)
 - [Bundler](https://bundler.io/)

### Installation

You can install all necessary dependencies with Bundler.
```
$ bundle install
```
It will install:
 - [Jekyll](https://jekyllrb.com/)
 - [HTMLProofer](https://github.com/gjtorikian/html-proofer)

## Build

The site will be built into a `_site` directory.
```
$ bundle exec jekyll build
```

## Running the tests
To run the tests with HTMLProofer, you need to use the following command:
```
$ bundle exec htmlproofer _site --check-html --enforce-https --report-invalid-tags --report-eof-tags --report-mismatched-tags --http_status_ignore 403,999
```
