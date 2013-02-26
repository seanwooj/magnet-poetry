class Poem < ActiveRecord::Base
  attr_accessible :name, :round_id, :user_id
end
