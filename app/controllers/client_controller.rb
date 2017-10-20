class ClientController < ApplicationController

  layout "client_application"

  def index
    unless session[:user_id]
      redirect_to :action => "user_login"
    end
  end
  
  def user_login
    if session[:user_id]
      redirect_to :action => "index"
    end
  end
      
  def user_create
    user = User.new
    user.name = params[:user_name]
    user.save
    
    session[:user_name] = user.name
    session[:user_id] = user.id
    
    redirect_to :action => "index"
  end

  def post_cheer
    player = Player.now_playing_player
    cheer = player.cheers.build
    cheer.user_id = session[:user_id]
    cheer.save
  end

end
