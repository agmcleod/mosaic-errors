require 'rspec'

RSpec.configure do |config|
  # Dir[File.join(File.expand_path('../..', __FILE__), 'lib/**/*.rb')].each { |f| require f }
  require File.join(File.expand_path('../..', __FILE__), 'lib/generators/errors_generator.rb')
  config.order = "random"
end