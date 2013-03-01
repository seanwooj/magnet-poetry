class AddRoundLimitToGame < ActiveRecord::Migration
  def change
    add_column :games, :round_limit, :integer
  end
end
