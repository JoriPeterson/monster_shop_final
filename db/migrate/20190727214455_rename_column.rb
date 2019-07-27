class RenameColumn < ActiveRecord::Migration[5.1]
  def change
		rename_column :addresses, :type, :nickname
  end
end
