class Vote < ActiveRecord::Base
  attr_accessible :poem_id, :user_id
  belongs_to :poem
  belongs_to :user
end
