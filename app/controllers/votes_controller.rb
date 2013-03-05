class VotesController < ApplicationController
	def new
		@game = Game.find(params[:game_id])
    @user = current_user
    @current_round = @game.current_round
    @current_prompt = @current_round.prompt
    @poems = @current_round.poems
	end

	def create
		@vote = Vote.new
		@vote.update_attributes(
			user_id: params[:user_id],
			poem_id: params[:poem_id]
		)
		@game = Game.find(params[:game_id])
		@game.new_round
		redirect_to game_path(params[:game_id])
	end
end
