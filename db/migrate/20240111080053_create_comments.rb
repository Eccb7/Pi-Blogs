class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :user_id, null: false, foreign_key: { to_table: :users }
      t.references :post_id, null: false, foreign_key: { to_table: :users }
      t.text :text

      t.timestamps
    end
  end
end
