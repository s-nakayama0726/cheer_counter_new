class Player < ApplicationRecord
  has_many :cheers
  has_many :users, through: :cheers
  
  def self.now_playing_player
    find_by(:play_flg => 1)
  end
end
