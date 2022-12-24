class CreateRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :routes do |t|
      t.integer :post_id, null: false
      t.string :spot,     null: false
      t.date :date
      t.time :time
      t.text :caption, null: false
      t.timestamps
    end
  end
end
