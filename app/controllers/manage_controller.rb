class ManageController < ApplicationController
  def index
    @now_playing_player = Player.now_playing_player
  end

  def stop_playing
    Player.update(:play_flg => 0)

    redirect_to :action => "index"
  end

  def start_playing
    player = Player.new
    player.name = params[:name]
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
  
  def delete_players
    Player.all.each do | player |
      player.cheers.delete_all
      player.delete
    end
  	
  	redirect_to :action => "index"
  
  end
  
  def result
    players = Player.all
    pleyers_name = players.collect{|player| player.name; }
    player_got_wakarimi = players.collect{|player| player.cheers.count; }
    # グラフ（チャート）を作成 
    @each_dj_chart = LazyHighCharts::HighChart.new("graph") do |c|
      c.title(text: "DJ個別結果")
      c.xAxis(categories: pleyers_name, title: {text: "出演DJ"})
      c.yAxis(title: {text: "獲得分かりみ数"})
      c.series(name: "獲得分かりみ数", data: player_got_wakarimi )
      c.chart(type: "column")
    end
    
    cheer_data = []
    hours = []
    (7..1).each do | idx |
    	idx2 = idx+1
    	cheer_data << Cheer.where(:created_at => idx2.hour.ago..idx.hour.ago).count
    	hours << idx.hour.ago.strftime("%H：%M")
    end
    cheer_data << Cheer.where(:created_at => 1.hour.ago..Time.now).count
    hours << 1.hour.ago.strftime("%H：%M")
    hours << Time.now.strftime("%H：%M")
    
    # グラフ（チャート）を作成 
    @event_chart = LazyHighCharts::HighChart.new("graph") do |c|
      c.xAxis(categories: hours, title: {text: "時間"})
      c.title(text: "イベント総合結果")
      c.yAxis(title: {text: "獲得分かりみ数"})
      c.series(name: "獲得分かりみ数", data: cheer_data )
      
    end
  end

end
