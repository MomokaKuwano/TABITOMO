class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :user_id, null: false
      
      t.timestamps
    end
  end
end
