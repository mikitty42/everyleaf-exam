class AddIndexToTasksStatus < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :status, unique: true
  end
end
