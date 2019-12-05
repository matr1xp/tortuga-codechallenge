class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :website
      t.string :heading
      t.string :short_url
      t.timestamps
    end

    create_table :friends do |t|
      t.belongs_to :member
      t.timestamps
    end
  end
end
