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
    
    to = Time.now
    from = to.ago(15)
    cheer_step_a_minute = @cheers.where(created_at: from..to).size
    
    if cheer_step_a_minute >= 2
      step_status = 1
    elsif cheer_step_a_minute == 0
      step_status = -1
    elsif cheer_step_a_minute == 1
      step_status = 0
    end

    status = {counter: @cheers.count, step_status: step_status}
    render :json => status and return
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
