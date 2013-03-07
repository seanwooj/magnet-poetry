class Word < ActiveRecord::Base
  attr_accessible :category_id, :word

  has_many :poem_words
  belongs_to :category

  def self.get_random(category, number)
    words = []
    length = Word.where(category_id: category).length
    number.times do
      words << Word.where(category_id: category)[rand(length)]
    end
    words
  end

  def self.seed_words
    seed_words = []
    (1..9).each do |num|
      seed_words << get_random(num, 3);
    end
    seed_words.flatten!
    seed_words
  end
end
