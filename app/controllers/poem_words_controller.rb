class PoemWordsController < ApplicationController
  def update
    @poem_word = PoemWord.find(params[:id])
    @poem_word.update_attributes(params[:poem_word])
    @poem_word.save

    respond_to do |format|
      format.json { render json: @poem_word }
    end
  end

end
