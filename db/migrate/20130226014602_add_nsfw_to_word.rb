class AddNsfwToWord < ActiveRecord::Migration
  def change
    add_column :words, :NSFW, :boolean, default: 0
  end
end
