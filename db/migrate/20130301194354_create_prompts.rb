class CreatePrompts < ActiveRecord::Migration
  def change
    create_table :prompts do |t|
      t.text :body
      t.boolean :nsfw, default: false

      t.timestamps
    end
  end
end
