class CreatePoems < ActiveRecord::Migration
  def change
    create_table :poems do |t|
      t.integer :user_id
      t.integer :round_id
      t.string :name

      t.timestamps
    end
  end
end
