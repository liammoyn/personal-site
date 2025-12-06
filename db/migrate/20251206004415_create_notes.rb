class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.text :content
      t.integer :topic_id

      t.timestamps
    end
  end
end
