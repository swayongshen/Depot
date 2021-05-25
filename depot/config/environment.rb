# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

Depot::Application.configure do
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: "mail.wright.com.sg",
    port: 587,
    domain: "wright.com.sg",
    authentication: "login",
    user_name: ENV["EMAIL_USERNAME"],
    password: ENV["EMAIL_PASSWORD"],
    enable_starttls_auto: true,
    openssl_verify_mode: 'none'
  }

  config.time_zone = 'Singapore'
end