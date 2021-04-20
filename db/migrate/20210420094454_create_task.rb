class CreateTask < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :notes
      t.datetime :start_time, :end_time

      t.timestamps
    end
  end
end
