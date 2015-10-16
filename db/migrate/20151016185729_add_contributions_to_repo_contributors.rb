class AddContributionsToRepoContributors < ActiveRecord::Migration
  def change
    add_column :repo_contributors, :contributions, :integer
  end
end
