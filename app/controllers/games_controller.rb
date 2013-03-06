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

    if @game.over?
      redirect_to winner_game_path(@game)
    elsif @current_round.all_submitted? && !@current_round.user_voted?(@user)
      redirect_to new_game_vote_path(@game.id)
    end
  end

  def index

  end

  def winner
    @game = Game.find(params[:id])
    unless @game.over?
      redirect_to @game
    end
  end

  def check_submissions
    @game = Game.find(params[:id])
    submitted = @game.current_round.all_submitted?
    voted = @game.current_round.all_voted?
    hash = { submitted: submitted, voted: voted }
    respond_to do |format|
      format.json { render json: hash }
    end
  end

end
