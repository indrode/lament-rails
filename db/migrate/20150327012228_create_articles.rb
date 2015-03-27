class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :number
      t.string :title
      t.string :blurb
      t.string :filename
      t.string :category
      t.text :copy
      t.datetime :posted_at

      t.timestamps null: false
    end
  end
end
