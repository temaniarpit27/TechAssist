class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :entity_id, null: false
      t.string :entity_type, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.boolean :vote_flag

      t.timestamps null: false
    end
    add_index :votes, [:entity_id, :entity_type]
  end
end
