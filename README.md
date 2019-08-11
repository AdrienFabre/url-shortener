[![Build Status](https://travis-ci.org/AdrienFabre/url-shortener.svg?branch=master)](https://travis-ci.org/AdrienFabre/url-shortener) [![Coverage Status](https://coveralls.io/repos/github/AdrienFabre/url-shortener/badge.svg?branch=master)](https://coveralls.io/github/AdrienFabre/url-shortener?branch=master)

# Url Shortener

This program helps users to create a short URL from any URL.

## User Story

As a user,
So I can create user friendly concise URLs,
I want to be able to paste my URL and get returned a short URL.

## Parameters

This programme needs to store many shorts URLs. We need to find a balance between the number of possibilities and the number of characters.

Enabling a-z, A-Z and 0-9 would enable 62 possible characters. With 6 characters, we could generate 6^62 short urls, so 56 800 235 584.

If we need more, we could remove links that have not been visited for over 6 months.

## Installation

```bash
bundle install
```

## Run App

```bash
shotgun config.ru
```

Run on: [http://localhost:9393/](http://localhost:9393/)
