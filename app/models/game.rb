class Game < ActiveRecord::Base
  attr_accessible :name, :user_id, :round_limit, :players_attributes, :user_ids

  has_many :rounds
  has_many :players, inverse_of: :game
  accepts_nested_attributes_for :players
  has_many :poems, through: :rounds
  has_many :users, through: :players

  # maybe crazy
  belongs_to :user

  def start_game
    round = self.rounds.build
    self.save
    Poem.create_player_poems(players, round.id)
    RoundPrompt.generate_random(round.id)
    self
  end

  def player_by_user_id(user_id)
    self.players.where(user_id: user_id)[0]
  end

  #this might actually be a helper
  def current_round
    self.rounds.last
  end

  def over?
    if self.current_round.round_number >= self.round_limit && self.current_round.all_voted?
      return true
    else
      return false
    end
  end

  def get_winner

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
