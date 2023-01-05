class RemovePokemonNameFromDeals < ActiveRecord::Migration[7.0]
  def change
    remove_column :deals, :pokemon_name, :string
  end
end
