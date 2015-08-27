require 'rspec'
require 'watir-webdriver'

browser = Watir::Browser.new

RSpec.configure do |config|

  config.before(:suite) do
    $browser = browser
    $browser.goto 'http://www.kalmban.com'
  end

  config.after(:suite) do
    $browser.close unless $browser.nil?
  end

end
