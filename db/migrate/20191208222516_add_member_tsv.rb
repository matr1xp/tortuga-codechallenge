class AddMemberTsv < ActiveRecord::Migration[5.0]
  def change
  	add_column :members, :tsv, :tsvector
  end
end
