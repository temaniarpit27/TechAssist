class AddColumnsToRepoContributors < ActiveRecord::Migration
  def change
  	add_column :repo_contributors, :user_id, :integer 
  	add_column :repo_contributors, :repository_id, :integer
  end
end
