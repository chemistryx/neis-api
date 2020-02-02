Jets.application.routes.draw do
  root "application#index"
  get "meal", to: "meal#index"
  get  "meal/:schoolCode/:schoolStage/:year/:month", to: "meal#show"

  any "*catchall", to: "jets/public#show"
end
