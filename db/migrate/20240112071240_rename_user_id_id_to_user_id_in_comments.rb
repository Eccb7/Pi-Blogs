class RenameUserIdIdToUserIdInComments < ActiveRecord::Migration[7.1]
  def change
    rename_column :comments, :new_user_id, :user_id
  end
end
