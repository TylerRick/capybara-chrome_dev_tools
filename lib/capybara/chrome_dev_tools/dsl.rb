module Capybara::ChromeDevTools::DSL
  [
    :dev_tools
  ].each do |method|
    define_method method do |*args, &block|
      page.send method, *args, &block
    end
  end
end
