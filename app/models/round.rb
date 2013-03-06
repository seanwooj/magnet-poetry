class Round < ActiveRecord::Base
  attr_accessible :game_id, :round_number, :round_prompt, :prompt

  has_many :poems
  has_many :players
  has_one :round_prompt
  has_one :prompt, through: :round_prompt
  has_many :votes

  belongs_to :game

  def all_submitted?
    self.poems.each do |poem|
      if !poem.game_played
        return false
      end
    end

    true
  end

  def all_voted?
    self.game.users.each do |user|
      return false if !self.user_voted?(user)
    end
    true
  end

  def user_voted?(user)
    self.votes.each do |vote|
      return true if vote.user_id == user.id
    end
    false
  end

  def get_best_poem
    best_poem = nil
    self.poems.each do |poem|
      if best_poem == nil
        best_poem = poem
      elsif poem.get_score > best_poem.get_score
        best_poem = poem
      end
      best_poem[0]
    end
  end

  def get_poem_scores
    poems = {}
    self.poems.each do |poem|
      poems[poem.id] = poem.get_score
    end
    poems
  end

end
