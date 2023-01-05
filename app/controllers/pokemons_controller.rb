class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all.order(name: :asc)

    # Finding Bitcoin rate
    api_key = '181edf265ab80e07441e75e6111435f4347ebf5703a1ca0d8ec4b53efb437e94'
    response = HTTParty.get("https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=BRL&api_key=#{api_key}")
    @bitcoin_rate = response["BRL"].to_f


    # Finding Pokemons data
    # response = HTTParty.get('https://pokeapi.co/api/v2/pokemon')
    # results = response['results']
    # @pokemons = []
    # results.each do |result|
    #   url = result["url"]
    #   r = HTTParty.get(url)
    #   experience = r["base_experience"].to_f
    #   @pokemons << {
    #     name: result["name"].capitalize,
    #     picture: r["sprites"]["front_default"],
    #     value: experience * @bitcoin_rate * 0.00000001
    #   }
  end



    # @pokemons = []
    # results.each do |result|
    #   @pokemons <<
    #   {
    #     name: result["name"],
    #     url: result["url"]
    #   }
    # end

  def show
    # recipe_response = HTTParty.get("https://api.edamam.com/api/recipes/v2/#{params[:id]}?type=public&app_id=#{ENV['ID_KEY']}&app_key=%20#{ENV['API_KEY']}%09")
    # @recipe = recipe_response["recipe"]
  end

end
