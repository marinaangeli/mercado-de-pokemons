class Pokemon < ApplicationRecord
  has_many :deals, dependent: :destroy

  # Finding Pokemons data
  # response = HTTParty.get('https://pokeapi.co/api/v2/pokemon')
  # results = response['results']
  # @pokemons = []
  # results.each do |result|
  #   url = result["url"]
  #   r = HTTParty.get(url)
  #   experience = r["base_experience"].to_d
  #   @pokemons << {
  #     name: result["name"].capitalize,
  #     picture: r["sprites"]["front_default"],
  #     value: experience * @bitcoin_rate * 0.00000001
  #   }


end
