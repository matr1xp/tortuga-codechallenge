class CreateStopwords < ActiveRecord::Migration[5.0]
  def change
    create_table :stopwords do |t|
      t.string :word
      t.integer :score

      t.timestamps
    end
  end
end
