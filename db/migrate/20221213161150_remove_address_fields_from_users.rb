class RemoveAddressFieldsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :house
    remove_column :users, :floor
    remove_column :users, :street
  end
end
