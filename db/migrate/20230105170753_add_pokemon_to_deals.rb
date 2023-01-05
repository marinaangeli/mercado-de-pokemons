class AddPokemonToDeals < ActiveRecord::Migration[7.0]
  def change
    add_reference :deals, :pokemon, null: false, foreign_key: true
  end
end
