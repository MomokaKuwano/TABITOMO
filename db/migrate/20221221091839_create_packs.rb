class CreatePacks < ActiveRecord::Migration[6.1]
  def change
    create_table :packs do |t|
      t.string :pack_title, null: false

      t.timestamps
    end
  end
end
