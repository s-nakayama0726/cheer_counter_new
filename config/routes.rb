Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "application#index"
  post "/post_cheer" => "application#post_cheer"
  get "/get_cheers" => "application#get_cheers"
  get "/client" => "application#client"
end
