class CreateRepoContributors < ActiveRecord::Migration
  def change
    create_table :repo_contributors do |t|

      t.timestamps null: false
    end
  end
end
