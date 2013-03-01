class GamesController < ApplicationController
  before_filter :authenticate_user!

  def new

  end

  def create
    
  end

  def show
    @game = Game.find(params[:id])
    @user = current_user
    @player_poem = Poem
      .joins("JOIN rounds ON rounds.id = poems.round_id")
      .where("rounds.game_id = ? AND
              poems.user_id = ? AND
              rounds.round_number = ?",
              params[:id], current_user.id, @game.current_round)
      .last
    @poem_words = @player_poem.poem_words
  end

  def index

  end

end
