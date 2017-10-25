Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "client#user_login"
  
  # master
  namespace :master do
    get "index"
    get "get_cheers"
    get "stanby"
    get "get_status"
    get "get_message"
    get "fever"
    get "get_users"
  end

  # client
  namespace :client do
    get "index"
    get "user_login"
    post "user_create"
    post "post_cheer"
    get "countdown"
  end
  
  # manage
  namespace :manage do
    post "start_playing"
    post "stop_playing"
    get "index"
    get "delete_users"
    get "delete_players"
    get "result"
  end
end
