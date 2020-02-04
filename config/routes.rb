Jets.application.routes.draw do
  root "application#index"

  get "meal", to: "meal#index"
  get "meal/:schoolCode/:schoolStage/:year/:month", to: "meal#show"

  get "schedule", to: "schedule#index"
  get "schedule/:schoolCode/:schoolStage/:year/:month", to: "schedule#show"

  any "*catchall", to: "jets/public#show"
end
