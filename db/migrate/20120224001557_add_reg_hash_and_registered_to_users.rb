class AddRegHashAndRegisteredToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reg_hash, :string
    add_column :users, :registered, :boolean
  end
end
