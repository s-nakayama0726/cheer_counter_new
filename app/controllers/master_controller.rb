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
    from = to.ago(5)
    cheer_step_a_minute = @cheers.where(created_at: from..to).size
    
    from = to.ago(60)
    twitter_access
    tweets = @client.search("#ガチ恋ガーデン #わかりみ since:#{from.strftime('%Y-%m-%d_%H:%M:%m')}_JST until:#{to.strftime('%Y-%m-%d_%H:%M:%m')}_JST", result_type: "recent", exclude: "retweets", since_id: nil)
    
    player = Player.now_playing_player
    
    tweets.each do |tw|
      if player
        cheer = player.cheers.build
        cheer.user_id = 1
        cheer.save
      end
    end
    
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

private
  def twitter_access
    @client = Twitter::REST::Client.new do |config|
    config.consumer_key = "EBHKOkhqFc87vYeC3qBuwiUY8"
    config.consumer_secret = "VQXctGMKGWA914TlobhrQlfL8Vq1oW1caRiVEuqEjc0nHO6BZ3"
    config.access_token = "726089982-oaNJ3NMiVKcKXp6IRoY7o3RyJ2eWWdlUfSAix9pk"
    config.access_token_secret = "3l7Dk1NQR4j8kXUOMiSYVArc01Cx6WqpK54qHdfMaVQJx"
    end
  end
end
