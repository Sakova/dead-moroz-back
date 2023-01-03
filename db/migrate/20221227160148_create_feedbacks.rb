class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.string :review
      t.references :user, null: false, foreign_key: true
      t.integer :created_by, null: false, index: true

      t.timestamps
    end
  end
end
