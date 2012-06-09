Mixxy::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # ActionMailer Config
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  # change to true to allow email to be sent during development
  config.action_mailer.perform_deliveries = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default :charset => "utf-8"

  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "example.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_PASSWORD"]
  }



  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin


  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  
  ENV["FACEBOOK_APP_ID"] = '380684265312885'
  ENV["FACEBOOK_APP_SECRET"] = 'ceaceb4568d747e60ed33a818d16bdcf'
  
  ENV["RDIO_APP_KEY"] = 'annhyg8fhmx2dmv3anuwd4c6'
  ENV["RDIO_APP_SECRET"] = 'dNChnk5UBN'
  
  ENV["SC_APP_ID"] = '2904496b907a52e9e1aea2e33586f399'
  ENV["SC_APP_SECRET"] = '05d608c205f50d8f78c7418daf67909a'
  
  ENV["YT_APP_KEY"] = 'AI39si4KSBLgXPqI4nwsHv7X0XasbJAHel7_VpCc8cwHGITP2Cx96fmHMwRfi5dcC-ZZw2G6TJxsKRSC6Dbgc1tvDA25jvCFxA'
  
end
