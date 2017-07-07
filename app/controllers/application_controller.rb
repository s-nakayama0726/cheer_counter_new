class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @now_playing_user = Player.now_playing_users.first
    @cheers = @now_playing_user.cheers if @now_playing_user
  end

  def post_cheer
    player = Player.now_playing_users.first
    cheer = player.cheers.build
    #cheer.message = params[:message]
    cheer.save
  end

  def get_cheers
    @cheers = Player.now_playing_users.first.cheers
  end

  def client
  end

  def stanby
  end
 
  def get_status
    now_playing_user = Player.now_playing_users.first
    if now_playing_user
      status = {status: "playing"}
      render :json => status and return
    else
      status = {status: "stanby"}
      render :json => status and return
    end
  end

  def get_message
    @cheers = Player.now_playing_users.first.cheers
    @message = @cheers.last.message
  end
end
