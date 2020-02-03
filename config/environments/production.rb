Jets.application.configure do
  config.function.memory_size = 384

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # Docs: http://rubyonjets.com/docs/email-sending/
  # config.action_mailer.raise_delivery_errors = false
end
