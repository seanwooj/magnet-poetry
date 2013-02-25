class CreateSinglePoems < ActiveRecord::Migration
  def change
    create_table :single_poems do |t|

      t.timestamps
    end
  end
end
