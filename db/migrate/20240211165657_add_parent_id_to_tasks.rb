class AddParentIdToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :parent_id, :integer
    add_index :tasks, :parent_id
  end
end
