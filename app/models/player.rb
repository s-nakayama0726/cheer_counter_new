class Player < ApplicationRecord
  has_many :cheers, dependent: :destroy

  scope :now_playing_users, -> { where(play_flg: 1) }
end
