Jets.application.configure do
  config.project_name = "neis-api"
  config.mode = "api"

  config.prewarm.enable = true
  config.prewarm.rate = "2 hours"

  config.controllers.default_protect_from_forgery = false
end
