# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Launchpad::Application.initialize!

config.action_mailer.default_url_options = { :host => 'localhost:3000' }