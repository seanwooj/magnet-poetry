class PoemsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @poem = Poem.new
    @poem.user_id = current_user.id
    @poem.save

    word_spawn(@poem.id)

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
    word_spawn(params[:id])
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

  private

    def word_spawn(poem_id)
      @words = Word.seed_words
      @words.each do |word|
        randTop = Random.rand(100)
        randLeft = Random.rand(100)
        poem_word = PoemWord.new( poem_id: poem_id,
                                  word_id: word.id,
                                  top: "#{randTop}%", left: "#{randLeft}%")
        poem_word.save
      end
    end

end
