class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, index: true, foreign_key: true
      t.references :repository, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
