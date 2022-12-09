class AddItemsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :items, :text, array: true, default: []
  end
end
