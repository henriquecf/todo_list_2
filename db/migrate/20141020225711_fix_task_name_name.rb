class FixTaskNameName < ActiveRecord::Migration
  def change
    rename_column :tasks, :name, :task_name
  end
end
