class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.string :pokemon_name
      t.date :buy_date
      t.decimal :buy_price
      t.date :sell_date
      t.decimal :sell_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
