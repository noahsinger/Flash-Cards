class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :deck
      t.string :content
      t.integer :position

      t.timestamps
    end
    add_index :cards, :deck_id
  end
end
