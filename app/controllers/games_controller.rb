class GamesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @game = Game.new
    @users = User.all
    @game.players.build
  end

  def create
    @game = Game.new(params[:game])
    @game.user_id = current_user.id
    if @game.save
      render 'new'
    else
      render 'new'
    end
  end

  def show
    @game = Game.find(params[:id])
    @user = current_user
    @player_poem = Poem
      .joins("JOIN rounds ON rounds.id = poems.round_id")
      .where("rounds.game_id = ? AND
              poems.user_id = ? AND
              rounds.round_number = ?",
              params[:id], current_user.id,
              @game.current_round.round_number)
      .last
    @poem_words = @player_poem.poem_words
    @current_round = @game.current_round
    @current_prompt = @current_round.prompt
  end

  def index

  end

  def vote
    @game = Game.find(params[:id])
    @user = current_user
    @current_round = @game.current_round
    @current_prompt = @current_round.prompt
    @poems = @current_round.poems
  end

  def cast_vote
  end

end
