require "capybara/chrome_dev_tools/version"

module Capybara::ChromeDevTools
  autoload :DriverExtensions, 'capybara/chrome_dev_tools/driver_extensions'
  autoload :DSL,              'capybara/chrome_dev_tools/dsl'

  class << self
    attr_accessor :enabled
    attr_accessor :preferred_port
  end
  self.enabled = false
  self.preferred_port = 9222
end

Capybara::Selenium::Driver.class_eval do
  prepend Capybara::ChromeDevTools::DriverExtensions
end

Capybara::Session.class_eval do
  ##
  # Returns a client for the browser's dev tools protocol. Not supported by all drivers.
  def dev_tools
    driver.dev_tools
  end
end

module Capybara::DSL
  include Capybara::ChromeDevTools::DSL
end
