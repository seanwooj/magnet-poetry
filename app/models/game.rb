class Game < ActiveRecord::Base
  attr_accessible :name, :user_id

  has_many :rounds
  has_many :players
  has_many :poems, through: :rounds

  def self.start_game(creator, players, name)

    @players = players

    game = Game.new(
      name: name,
      user_id: creator.id,
    )

    round = game.rounds.build(
      round_number: 1,
    )

    game.save

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
