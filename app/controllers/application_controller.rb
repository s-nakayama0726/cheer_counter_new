class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def master
    @now_playing_user = Player.now_playing_users.first
    @cheers = @now_playing_user.cheers if @now_playing_user
    @users = User.all
  end
  
  def fever
    @now_playing_user = Player.now_playing_users.first
    @cheers = @now_playing_user.cheers if @now_playing_user
  end

  def get_cheers
    @cheers = Player.now_playing_users.first.cheers
    @users = User.all.sort{|a, b| b.cheers.count <=> a.cheers.count }
  end

  def stanby
  end
 
  def get_status
    now_playing_user = Player.now_playing_users.first
    if now_playing_user
      if now_playing_user.cheers.count > 50
        status = {status: "fever"}
        render :json => status and return
      else
        status = {status: "playing"}
        render :json => status and return
      end
    else
      status = {status: "stanby"}
      render :json => status and return
    end
  end
end
