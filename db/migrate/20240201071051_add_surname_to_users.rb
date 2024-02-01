class AddSurnameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :surname, :string
  end
end
