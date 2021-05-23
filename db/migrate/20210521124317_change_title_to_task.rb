class ChangeTitleToTask < ActiveRecord::Migration[6.1]
  def change
    change_column(:tasks, :title, :string, unique: true, limit: 50)
  end
end
