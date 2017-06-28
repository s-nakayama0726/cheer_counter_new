class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @cheers = Cheer.all
  end

  def post_cheer
    Cheer.create
  end

  def get_cheers
    @cheers = Cheer.all
  end

  def client
  end
end
