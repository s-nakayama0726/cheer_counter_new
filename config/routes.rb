Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "client#user_login"
  
  # master
  get "/master" => "application#master"
  get "/get_cheers" => "application#get_cheers"
  get "/stanby" => "application#stanby"
  get "/get_status" => "application#get_status"
  get "/get_message" => "application#get_message"
  get "/fever" => "application#fever"
  get "/get_users" => "application#get_users"

  # client
  get "/client" => "client#client"
  get "/user_login" => "client#user_login"
  post "/user_create" => "client#user_create"
  post "/post_cheer" => "client#post_cheer"
  
  # manage
  post "/manage/start_playing" => "manage#start_playing"
  post "/manage/stop_playing" => "manage#stop_playing"
  get "/manage/index" => "manage#index"
end
