class Game < ActiveRecord::Base
  attr_accessible :name, :user_id

  has_many :rounds
  # has_many :players # don't know about this.
  has_many :poems, through: :rounds

  def self.initialize(creator, players, name)

    @players = players

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

    Poem.create_player_poems(@players, round.id)

  end

  #this might actually be a helper
  def current_round
    self.rounds.last.round_number
  end

  def game_over?

  end

  def new_round
    round = Round.create(
      game_id: self.id,
      round_number: current_round + 1
    )

    Poem.create_player_poems(@players, round.id)

  end


end
