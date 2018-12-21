# Capybara::ChromeDevTools

Integrates [chrome_remote](https://github.com/cavalle/chrome_remote) (a Chrome DevTools Protocol
client) with Capybara, letting you access Chrome DevTools via `driver.dev_tools`.

## Installation

Install crmux by running, for example:
```
npm install crmux -g
```
or
```
yarn add crmux
```

Test that you can run it with:
```
npx crmux --help
```

Add this line to your application's Gemfile:

```ruby
gem 'capybara-chrome_dev_tools'
```

## Usage

Access a ChromeRemote instance with `dev_tools`.

See [chrome_remote](https://github.com/cavalle/chrome_remote) for API documentation.

Example:
```ruby
dev_tools.send_cmd "Page.enable"
```

## See also

To get access to HTTP response status code, response headers, etc. from your tests, check out https://github.com/TylerRick/capybara-chrome_response_headers, which uses this gem.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TylerRick/capybara-chrome_dev_tools.
