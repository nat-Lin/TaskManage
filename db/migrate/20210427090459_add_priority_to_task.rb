class AddPriorityToTask < ActiveRecord::Migration[6.1]
  def change
    change_table :tasks do |t|
      t.integer :priority, default: 0
      t.index :status
    end
  end
end
