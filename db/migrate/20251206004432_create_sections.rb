class CreateSections < ActiveRecord::Migration[8.0]
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :article_id
      t.string :placement
      t.text :text_content

      t.timestamps
    end
  end
end
