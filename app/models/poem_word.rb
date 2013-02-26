class PoemWord < ActiveRecord::Base
  attr_accessible :left, :poem_id, :top, :word_id

  belongs_to :poem
  belongs_to :word
end
