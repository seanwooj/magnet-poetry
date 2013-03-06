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
    @current_round = @game.current_round
		@vote = Vote.new

    Vote.transaction do

  		@vote.update_attributes(
  			user_id: params[:user_id],
  			poem_id: params[:poem_id],
        round_id: @game.current_round.id
  		)

      if @current_round.all_voted?
        winning_user_id = @current_round.get_best_poem.user_id
        winning_player = @game.player_by_user_id(winning_user_id)
        winning_player.points += 1
        winning_player.save
        unless @game.over?
          @game.new_round
        end
      end

    end

    if @game.over?
      redirect_to winner_game_path(@game)
    else
		  redirect_to game_path(params[:game_id])
    end
	end
end
