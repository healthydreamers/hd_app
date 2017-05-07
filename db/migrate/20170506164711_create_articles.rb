class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false, default: ""
      t.text :description, null: false, default: ""
      t.string :url, default: ""
      t.string :source_host, default: ""
      t.string :slug
      t.references :topic, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :articles, :slug, unique: true
  end
end
