lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "capybara/chrome_dev_tools/version"

Gem::Specification.new do |spec|
  spec.name          = "capybara-chrome_dev_tools"
  spec.version       = Capybara::ChromeDevTools.version
  spec.authors       = ["Tyler Rick"]
  spec.email         = ["tyler@tylerrick.com"]
  spec.license       = "MIT"

  spec.summary       = %q{Integrates [chrome_remote](https://github.com/cavalle/chrome_remote) (a Chrome DevTools Protocol
client) with Capybara, letting you access Chrome DevTools via `driver.dev_tools`.}
  #spec.description   = %q{}
  spec.homepage      = "https://github.com/TylerRick/capybara-chrome_dev_tools"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.metadata["source_code_uri"]}/blob/master/Changelog.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3.0"
  spec.add_dependency "chrome_remote"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
