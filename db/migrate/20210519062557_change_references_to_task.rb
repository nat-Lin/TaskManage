class ChangeReferencesToTask < ActiveRecord::Migration[6.1]
  def change
    remove_reference(:tasks, :user, foreign_key: true)
    add_reference(:tasks, :user, foreign_key: {on_update: :cascade, on_delete: :cascade})
  end
end
