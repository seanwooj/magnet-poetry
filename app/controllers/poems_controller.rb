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

  def refresh_words
    @poem = Poem.find(params[:id])
    @poem_words = @poem.poem_words.includes(:word).all

    respond_to do |format|
      format.json { render json: @poem_words }
    end
  end


end
