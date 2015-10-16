class CreateUserRepoJoins < ActiveRecord::Migration
  def change
    create_table :user_repo_joins do |t|
      t.integer :user_id , null: false
      t.integer :repo_id , null: false

      t.timestamps null: false
    end
  end
end
