class AddNsfwToWord < ActiveRecord::Migration
  def change
    add_column :words, :NSFW, :boolean, default: false
  end
end
