class PoemsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @poem = Poem.new
    @poem.user_id = current_user.id
    @words = Word.seed_words
    @poem.save
    @words.each do |word|
      poem_word = PoemWord.new(poem_id: @poem.id, word_id: word.id, top: "0%", left: "0%")
      poem_word.save
    end
    redirect_to @poem
  end

  def edit

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

end
