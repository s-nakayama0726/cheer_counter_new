class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @now_playing_user = Player.now_playing_users.first
    @cheers = @now_playing_user.cheers
  end

  def post_cheer
    player = Player.now_playing_users.first
    cheer = player.cheers.build
    cheer.save
  end

  def get_cheers
    @cheers = Player.now_playing_users.first.cheers
  end

  def client
  end
end
