class Game < ActiveRecord::Base
  attr_accessible :name, :user_id

  has_many :rounds
  # has_many :players # don't know about this.
  has_many :poems, through: :rounds

  def self.instantiate_game(creator, players, name)

    game = Game.new(
      name: name,
      user_id: creator.id,
    )
    game.save!

    round = Round.create(
      game_id: game.id,
      round_number: 1,
      # BE SURE TO ADD PROMPT
    )

    players.each do |player|
      poem = Poem.instantiate_poem(player.id)
    end

  end
end
