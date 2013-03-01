class Round < ActiveRecord::Base
  attr_accessible :game_id, :round_number, :round_prompt, :prompt

  has_many :poems
  has_many :players
  has_one :round_prompt
  has_one :prompt, through: :round_prompt

  belongs_to :game

  def all_submitted?
    self.poems.each do |poem|
      if !poem.game_played
        return false
      end
    end

    true
  end

end
