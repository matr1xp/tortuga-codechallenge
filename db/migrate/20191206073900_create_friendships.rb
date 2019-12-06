# db/migrations/create_friendships.rb
class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :member, index: true, foreign_key: true
      t.references :friend, index: true

      t.timestamps null: false
    end

    add_foreign_key :friendships, :members, column: :friend_id
    add_index :friendships, [:member_id, :friend_id], unique: true
  end
end