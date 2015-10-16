class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :entity_id, null: false
      t.string :entity_type, null: false
      t.string :comment
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :comments, [:entity_id, :entity_type]
  end
end
