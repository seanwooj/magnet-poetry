class Player < ActiveRecord::Base
  attr_accessible :game_id, :points, :user_id

  belongs_to :user
  belongs_to :game, inverse_of: :players

end
