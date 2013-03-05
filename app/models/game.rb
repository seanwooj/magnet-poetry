class Game < ActiveRecord::Base
  attr_accessible :name, :user_id, :round_limit, :players_attributes

  has_many :rounds
  has_many :players, inverse_of: :game
  accepts_nested_attributes_for :players
  has_many :poems, through: :rounds
  has_many :users, through: :players

  # maybe crazy
  belongs_to :user

  def self.start_game(creator, users, name, round_limit)
    game = Game.new(
      name: name,
      user_id: creator.id,
      round_limit: round_limit
    )

    round = game.rounds.build(
      round_number: 1,
    )

    users.each do |user|
      game.players.build(
        user_id: user.id,
        points: 0
      )
    end

    game.save
    players = game.players
    Poem.create_player_poems(players, round.id)
    RoundPrompt.generate_random(round.id)
    game
  end

  def all_voted?
    
  end

  #this might actually be a helper
  def current_round
    self.rounds.last
  end

  def game_over?

  end

  def new_round
    round = Round.create(
      game_id: self.id,
      round_number: current_round.round_number + 1
    )

    Poem.create_player_poems(self.players, round.id)
    RoundPrompt.generate_random(round.id)
  end


end
