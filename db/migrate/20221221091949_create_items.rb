class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :item, null: false

      t.timestamps
    end
  end
end
