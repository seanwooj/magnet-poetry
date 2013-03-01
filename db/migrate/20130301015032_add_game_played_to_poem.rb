class AddGamePlayedToPoem < ActiveRecord::Migration
  def change
    add_column :poems, :game_played, :boolean, default: false
  end
end
