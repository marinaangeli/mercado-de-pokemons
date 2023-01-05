class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all.order(name: :asc)

    # Finding Bitcoin rate
    api_key = '181edf265ab80e07441e75e6111435f4347ebf5703a1ca0d8ec4b53efb437e94'
    response = HTTParty.get("https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=BRL&api_key=#{api_key}")
    @bitcoin_rate = response["BRL"].to_d
  end

  def show
    # recipe_response = HTTParty.get("https://api.edamam.com/api/recipes/v2/#{params[:id]}?type=public&app_id=#{ENV['ID_KEY']}&app_key=%20#{ENV['API_KEY']}%09")
    # @recipe = recipe_response["recipe"]
  end

end
