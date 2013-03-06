class VotesController < ApplicationController
	def new
		@game = Game.find(params[:game_id])
    @user = current_user
    @current_round = @game.current_round
    @current_prompt = @current_round.prompt
    @poems = @current_round.poems
	end

	def create
    @game = Game.find(params[:game_id])
		@vote = Vote.new
		@vote.update_attributes(
			user_id: params[:user_id],
			poem_id: params[:poem_id],
      round_id: @game.current_round.id
		)
		redirect_to game_path(params[:game_id])
	end
end
