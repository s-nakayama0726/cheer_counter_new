class ClientController < ApplicationController

  def client
    unless session[:user_id]
      redirect_to :action => "user_login"
    end
  end
  
  def user_login
    if session[:user_id]
      redirect_to :action => "client"
    end
  end
      
  def user_create
    user = User.new
    user.user_name = params[:user_name]
    user.save
    
    session[:user_name] = user.user_name
    session[:user_id] = user.id
    
    redirect_to :action => "client"
  end

  def post_cheer
    player = Player.now_playing_users.first
    cheer = player.cheers.build
    cheer.user_id = session[:user_id]
    #cheer.message = params[:message]
    cheer.save
  end

end
