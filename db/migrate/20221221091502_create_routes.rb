class CreateRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :routes do |t|
      t.string :spot,     null: false
      t.integer :date
      t.integer :time
      t.text :caption, null: false
      t.timestamps
    end
  end
end
