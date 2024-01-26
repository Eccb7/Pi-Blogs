class RenameUserIdIdToUserIdInComments < ActiveRecord::Migration[7.1]
  def change
    rename_column(:comments, :user_id, :new_user_id)
  end
end
