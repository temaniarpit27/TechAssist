class FixColumn < ActiveRecord::Migration
  def change
    rename_column :user_repo_joins, :repo_id, :repository_id
  end
end
