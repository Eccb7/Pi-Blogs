class RenameUserIdIdToUserIdInComments < ActiveRecord::Migration[7.1]
  def change
    rename_column :comments, :user_id_id, :user_id
  end
end