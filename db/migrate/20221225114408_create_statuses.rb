class CreateStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :statuses do |t|
      t.integer :user_id, null: false
      t.string :spot,     null: false
      t.date :date
      t.time :time
      t.text :caption, null: false
      t.timestamps
    end
  end
end
