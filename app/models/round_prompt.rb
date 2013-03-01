class RoundPrompt < ActiveRecord::Base
  attr_accessible :prompt_id, :round_id

  belongs_to :round
  belongs_to :prompt

  def self.generate_random(round_id)
    RoundPrompt.create(round_id: round_id,
                       prompt_id: Prompt.get_random(true).id )
  end

  validates :round_id, presence: true
  validates :prompt_id, presence: true
end
