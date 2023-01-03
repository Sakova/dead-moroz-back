class CreateAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :assessments do |t|
      t.integer :star, null: false, default: 0
      t.string :comment, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :created_by, null: false, index: true

      t.timestamps
    end
  end
end
