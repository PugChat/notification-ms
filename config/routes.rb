Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "notifications/create"
  get "notifications/show"
  delete "notifications/destroy"

end
