require 'rspec'

RSpec.configure do |config|
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  
  config.order = "random"
end