class CreatePackingLists < ActiveRecord::Migration[6.1]
  def change
    create_table :packing_lists do |t|
      t.integer :list_id, null: false
      t.integer :item_id, null: false

      t.timestamps
    end
  end
end
