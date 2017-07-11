class Player < ApplicationRecord
  has_many :cheers
  has_many :users, through: :cheers

  scope :now_playing_users, -> { where(play_flg: 1) }
end
