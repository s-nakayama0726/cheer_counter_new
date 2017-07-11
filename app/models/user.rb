class User < ApplicationRecord
  has_many :cheers
  has_many :players, through: :cheers
end
