class Prompt < ActiveRecord::Base
  attr_accessible :body, :nsfw

  has_many :round_prompts

  def self.get_random(nsfw = false)
    unless nsfw == false
      length = Prompt.all.length
      p "what the hell?"
      return Prompt.all[rand(length)]
    end

    length = Prompt.where(nsfw: false).length
    Prompt.where(nsfw: false)[rand(length)]
  end
end
