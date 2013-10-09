# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
SecretSanta::Application.initialize!
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['app18565578@heroku.com'],
  :password       => ENV['fbvkym11'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}
