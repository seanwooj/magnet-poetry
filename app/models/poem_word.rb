class PoemWord < ActiveRecord::Base
  attr_accessible :left, :poem_id, :top, :word_id

  belongs_to :poem
  belongs_to :word

  def as_json(options = {})
    {
      word: self.word.word,
      left: self.left,
      top: self.top,
      id: self.id
    }
  end

end
