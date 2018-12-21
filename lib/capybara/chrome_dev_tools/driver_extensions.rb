require 'chrome_remote'

module Capybara::ChromeDevTools
  module DriverExtensions
    attr_accessor :chrome_debugging_port
    attr_accessor :crmux_listen_port

    def initialize(app, opts)
      #puts "#{self.class}#initialize"

      if opts[:browser] == :chrome and Capybara::ChromeDevTools.enabled
        start_crmux!(opts)
      end

      super
    end

    def find_free_port(port = 0)
      begin
        server = TCPServer.new('127.0.0.1', port)
      rescue Errno::EADDRINUSE
        if port == 0
          raise
        else
          # Lets you pass a preferred port to try first before falling back to 0
          port = 0
          retry
        end
      end
      server.addr[1].tap do |port|
        server.close
      end
    end

    # Starts crmux and adds debuggerAddress to opts that points to crmux listen address.
    def start_crmux!(opts)
      self.chrome_debugging_port = find_free_port(Capybara::ChromeDevTools.preferred_port)
      self.crmux_listen_port     = find_free_port(chrome_debugging_port + 1)
      opts[:options].args << "--remote-debugging-port=#{chrome_debugging_port}"
      #opts[:options].add_preference 'debuggerAddress', "127.0.0.1:#{crmux_listen_port}"

      @debug_crmux = true
      command = "npx crmux #{'-d' if @debug_crmux} \
                   --port=#{chrome_debugging_port} \
                   --listen=#{crmux_listen_port}"
      puts %(command: #{command}) if Capybara::ChromeDevTools.verbose >= 3
      if @debug_crmux
        spawn_opts = {[:out, :err] => 'log/crmux.log'}
      else
        spawn_opts = {}
      end
      @crmux_pid = spawn(command, spawn_opts)
      puts %(Started crmux [pid #{@crmux_pid}], listening at http://localhost:#{crmux_listen_port}, connected to localhost:#{chrome_debugging_port})
      # You can also get the part later with: page.driver.browser.capabilities["goog:chromeOptions"]["debuggerAddress"]
      sleep 0.1

      at_exit do
        puts "Killing crmux process #{@crmux_pid}..." if Capybara::ChromeDevTools.verbose >= 1
        Process.kill 'TERM', @crmux_pid
      end
    end

    def browser
      super.tap do |browser|
        dev_tools if Capybara::ChromeDevTools.enabled
      end
    end

    def dev_tools
      @dev_tools ||= (
        puts "Connecting to #{crmux_listen_port}..." if Capybara::ChromeDevTools.verbose >= 2
        ChromeRemote.client host: 'localhost', port: crmux_listen_port
      )
    end
  end
end
