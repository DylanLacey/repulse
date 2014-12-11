require 'sinatra'
require 'rack-webconsole'
require 'selenium/webdriver'

Rack::Webconsole.inject_jquery = true
Rack::Webconsole.key_code = "94"

class MySinatraApp < Sinatra::Application
  use Rack::Webconsole

  get '/repl' do
    server = "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:80/wd/hub"
    $driver = Selenium::WebDriver.for :remote, :url => server, :desired_capabilities => {browserName: 'Chrome', platform: 'Windows 7', version: 30}
    [200, [(erb :index)]]
  end

  run! if app_file == $0
end