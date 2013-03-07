class ChangeRoundDefaultToOne < ActiveRecord::Migration
  def change
    change_column :players, :points, :integer, default: 0
    change_column :rounds, :round_number, :integer, default: 1
  end
end
