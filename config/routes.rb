Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "battles#index"

  resources :battles,only:[:index,:show] do 
  	member do
  		get :rate_this_war
  	end
  end
end
