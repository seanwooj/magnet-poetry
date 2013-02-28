class Round < ActiveRecord::Base
  attr_accessible :game_id, :round_number

  has_many :poems
  has_many :players

  belongs_to :game

end
