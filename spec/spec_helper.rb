ENV['RACK_ENV'] = 'test'

require_relative File.join('..', 'app')

RSpec.configure do |_config|
  include Rack::Test::Methods

  def app
    App
  end
end