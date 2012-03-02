class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
    add_index :decks, :user_id
  end
end
