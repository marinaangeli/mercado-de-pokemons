class PokemonsController < ApplicationController
  before_action :set_satoshi_rate, only: :index

  def index
    @pokemons = Pokemon.all.order(name: :asc)
  end

  def show

  end

  private

  # Finding Bitcoin rate
  def set_satoshi_rate
    response = HTTParty.get("https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=BRL&api_key=#{ENV.fetch('API_KEY', nil)}")
    @satoshi_rate = response["BRL"].to_d*0.00000001
  end

end
