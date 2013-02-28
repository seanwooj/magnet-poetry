class Poem < ActiveRecord::Base
  attr_accessible :name, :round_id, :user_id

  has_many :poem_words, dependent: :destroy
  accepts_nested_attributes_for :poem_words

  has_many :words, through: :poem_words

  belongs_to :round
  belongs_to :game
  belongs_to :user

  def self.instantiate_poem(user_id, round_id = nil)
    poem = Poem.create(user_id: user_id, round_id: round_id)
    Poem.word_spawn(poem.id)
    poem
  end

  def self.word_spawn(poem_id)
    @words = Word.seed_words
    @words.each do |word|
      randTop = Random.rand(100)
      randLeft = Random.rand(100)
      poem_word = PoemWord.new( poem_id: poem_id,
                                word_id: word.id,
                                top: "#{randTop}%", left: "#{randLeft}%")
      poem_word.save
    end
  end

  def self.create_player_poems(players, round_id)
    players.each do |player|
      poem = Poem.instantiate_poem(player.id, round_id)
    end
  end

end
