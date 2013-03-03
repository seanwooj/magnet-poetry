class PoemsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @poem = Poem.instantiate_poem(current_user.id)

    redirect_to @poem
  end

  def index

  end

  def show
    @poem = Poem.find(params[:id])
    @poem_words = @poem.poem_words.includes(:word).all

    respond_to do |format|
      format.json { render json: @poem_words }
      format.html
    end
  end

  def spawn_new_words
    Poem.word_spawn(params[:id])
    @poem = Poem.find(params[:id])
    @poem_words = @poem.poem_words.includes(:word).all

    respond_to do |format|
      format.html { redirect_to @poem }
      format.js { render json: @poem_words }
    end
  end

  def submit
    @poem = Poem.find(params[:id])
    @round = @poem.round
    @poem.game_played = true
    @poem.save
    if @round.all_submitted?
      @round.all_submitted = true
      @round.save
    end

    respond_to do |format|
      format.json { render json: :nothing }
      format.html { redirect_to @round.game }
    end


  end


end
