class AddIndexOnNumberToArticles < ActiveRecord::Migration
  def change
    add_index :articles, :number
  end
end
