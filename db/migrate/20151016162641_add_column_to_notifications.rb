class AddColumnToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :seen_flag, :boolean, :default_value  => false
  end
end
