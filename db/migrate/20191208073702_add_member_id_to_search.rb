class AddMemberIdToSearch < ActiveRecord::Migration[5.0]
  def change
  	add_column :searches, :member_id, :integer
  end
end
