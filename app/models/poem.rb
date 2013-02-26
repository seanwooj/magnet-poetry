class Poem < ActiveRecord::Base
  attr_accessible :name, :round_id, :user_id

  has_many :poem_words
  has_many :words, through: :poem_words

  belongs_to :round
  belongs_to :user
end
