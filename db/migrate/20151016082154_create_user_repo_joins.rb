class CreateUserRepoJoins < ActiveRecord::Migration
  def change
    create_table :user_repo_joins do |t|
      t.integer :user_id
      t.integer :repo_id

      t.timestamps null: false
    end
  end
end
