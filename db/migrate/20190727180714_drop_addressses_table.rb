class DropAddresssesTable < ActiveRecord::Migration[5.1]
  def change
		drop_table :addresses_tables
  end
end
