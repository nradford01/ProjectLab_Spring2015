class AddFieldToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :complete, :boolean, :default => false
    add_column :tasks, :priority, :integer, :default => 2
  end
end
