class CreateTag < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, limit: 20, null: false
      t.references :user
      t.timestamps
    end

    change_column(:users, :name, :string, null: false, limit: 50)
    change_column(:tasks, :title, :string, null: false, limit: 50)
  end
end
