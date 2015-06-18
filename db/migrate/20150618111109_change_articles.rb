class ChangeArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :filename
    rename_column :articles, :copy, :markdown
  end
end
