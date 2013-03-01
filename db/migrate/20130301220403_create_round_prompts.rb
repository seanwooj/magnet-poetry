class CreateRoundPrompts < ActiveRecord::Migration
  def change
    create_table :round_prompts do |t|
      t.integer :round_id
      t.integer :prompt_id

      t.timestamps
    end
  end
end
