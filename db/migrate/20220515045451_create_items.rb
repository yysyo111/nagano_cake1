class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.integer :genre_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :tax_excluded_price, null: false
      t.boolean :sales_status, null: false, default: true

      t.timestamps
    end
  end
end
