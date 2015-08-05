Rails.application.routes.draw do
  resources(:missions)

  namespace :api do
    namespace :v1 do
      resources :missions
    end
  end
end
