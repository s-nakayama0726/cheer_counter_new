class MasterController < ApplicationController

  layout "master_application"

  def index
    @now_playing_player = Player.now_playing_player
    @cheers = @now_playing_player.cheers if @now_playing_player
    @users = User.all
  end
  
  def fever
    @now_playing_player = Player.now_playing_player
    @cheers = @now_playing_player.cheers if @now_playing_player
  end

  def get_cheers
    @cheers = Player.now_playing_player.cheers
    @users = User.all.sort{|a, b| b.cheers.count <=> a.cheers.count }
  end

  def stanby
  end
 
  def get_status
    now_playing_player = Player.now_playing_player
    if now_playing_player
      status = {status: "playing"}
      render :json => status and return
    else
      status = {status: "stanby"}
      render :json => status and return
    end
  end
end
