class ManageController < ApplicationController
  def index
    @now_playing_user = Player.now_playing_users.first
  end

  def stop_playing
    Player.update(:play_flg => 0)

    redirect_to :action => "index"
  end

  def start_playing
    player = Player.new
    player.player_name = params[:name]
    player.play_flg = 1
    player.save

    redirect_to :action => "index"
  end
  
  def delete_users
  	User.all.each do | user |
  	  user.cheers.delete_all
  	  user.delete
  	end
  	
  	redirect_to :action => "index"
  end

end
