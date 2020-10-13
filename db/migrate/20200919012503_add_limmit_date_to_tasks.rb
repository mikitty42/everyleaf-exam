class AddLimmitDateToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :limit_date, :date, null: false, default: '2015-10-20 19:22:41 +0900'
  end
end
