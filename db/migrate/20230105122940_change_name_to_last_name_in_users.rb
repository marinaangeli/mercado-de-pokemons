class ChangeNameToLastNameInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :name, :last_name
  end
end
