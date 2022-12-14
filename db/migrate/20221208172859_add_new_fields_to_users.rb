class AddNewFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :age, :integer
    add_column :users, :avatar, :string
    add_column :users, :street, :string
    add_column :users, :house, :integer
    add_column :users, :floor, :integer
  end
end
