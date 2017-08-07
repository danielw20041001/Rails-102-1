class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :goup_id
      t.integer :userid

      t.timestamps
    end
  end
end
