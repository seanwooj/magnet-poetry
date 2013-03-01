class Player < ActiveRecord::Base
  attr_accessible :game_id, :points, :user_id
end
