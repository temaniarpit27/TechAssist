class CreateAskedToAnswers < ActiveRecord::Migration
  def change
    create_table :asked_to_answers do |t|
      t.references :question, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
