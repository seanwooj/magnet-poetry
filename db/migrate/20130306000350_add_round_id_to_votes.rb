class AddRoundIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :round_id, :integer
  end
end
