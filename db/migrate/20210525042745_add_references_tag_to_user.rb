class AddReferencesTagToUser < ActiveRecord::Migration[6.1]
  def change
    remove_reference(:tags, :user)
    add_reference(:tags, :user, foreign_key: {on_update: :cascade, on_delete: :cascade})
  end
end
