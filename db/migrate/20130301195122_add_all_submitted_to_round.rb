class AddAllSubmittedToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :all_submitted, :boolean, default: false
    add_column :rounds, :all_voted, :boolean, default: false
  end
end
