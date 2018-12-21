# Capybara::ChromeDevTools

Integrates [chrome_remote](https://github.com/cavalle/chrome_remote) (a Chrome DevTools Protocol
client) with Capybara, letting you access Chrome DevTools via `driver.dev_tools`.

## What it does for you

- Finds a free port and sets Chrome's --remote-debugging-port to this known port
- Starts [`crmux`](https://github.com/sidorares/crmux) so that you can make additional connections
  to the Chrome DevTools/debugging port even while `chromedriver` continues to connect to the
  `--remote-debugging-port` (Chrome normally only allows one debugging session to be connected to a
  tab)
- Lets you inspect the browser window your tests are running in — even if they are running in a
  headless Chrome browser!
- Exposes a `dev_tools` method that provides access to a `ChromeRemote` instance (see
  [capybara-chrome_response_headers](https://github.com/TylerRick/capybara-chrome_response_headers),
  for one possible use for that)

Inspired by: https://stackoverflow.com/a/50876153/47185

## Installation

Install [`crmux`](https://github.com/sidorares/crmux) by running, for example:
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

Enable this extension like so:
```
Capybara::ChromeDevTools.enabled = true
```

... before you do any action with Capybara that triggers it to use the Chrome driver/browser.

### Accessing DevTools from another Chrome window

Add some code to your test to make it _pause_ at the point where you want to inspect the state of
the browser window. Otherwise, when the test finishes, it will close the window that you are
inspecting and disconnect the DevTools frontend that you were using to view it.

Look for the output which teels you which port it's listening to:

```
Started crmux [pid 56630], listening at http://localhost:35720, connected to localhost:35719
```

Now you can go to http://localhost:35720, choose which window to inspect, and inspect the Chrome
window that your tests are running in — all from this other Chrome browser instance!

You can also get the listen port from `driver.crmux_listen_port` if you want to
automate things.

### Accessing DevTools from Ruby

Access a ChromeRemote instance with `dev_tools`.

See [chrome_remote](https://github.com/cavalle/chrome_remote) for API documentation.

Example:
```ruby
dev_tools.send_cmd "Page.enable"
```

## Status

This project should be considered a proof of concept.

It generally works, but isn't exceptionally resilient or stable.

Sometimes you may get intermittent errors from `chrome_remote` or the WebSocket connection. There
should probably be some handling of these errors (or better yet, figure out what's causing the
errors).

## See also

To get access to HTTP response status code, response headers, etc. from your tests, check out https://github.com/TylerRick/capybara-chrome_response_headers, which uses this gem.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TylerRick/capybara-chrome_dev_tools.
