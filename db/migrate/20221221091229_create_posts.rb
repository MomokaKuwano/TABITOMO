class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :title
      t.boolean :status, default: false
      t.timestamps
    end
  end
end
