class DropFriendsTable < ActiveRecord::Migration[5.0]
  def up
  	drop_table :friends
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
