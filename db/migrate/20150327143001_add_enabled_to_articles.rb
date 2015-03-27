class AddEnabledToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :enabled, :boolean
  end
end
