class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.integer :topic_id
      t.string :title
      t.text :summary

      t.timestamps
    end
  end
end
