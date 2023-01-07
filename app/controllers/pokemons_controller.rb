class PokemonsController < ApplicationController
  before_action :set_satoshi_rate, only: :index
  def index
    sort_by = params[:sort_by]
    @pokemons = sort_pokemons(sort_by)
    set_satoshi_rate
  end

  def show

  end


  def sort
    sort_by = params[:sort_by]
    @pokemons = sort_pokemons(sort_by)
    redirect_to pokemons_path
  end

  private

  # Finding Bitcoin rate
  def set_satoshi_rate
    response = HTTParty.get("https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=BRL&api_key=#{ENV.fetch('API_KEY', nil)}")
    @satoshi_rate = response["BRL"].to_d*0.00000001
  end

  def sort_pokemons(sort_by)
    case sort_by
    when "lowest_price"
      Pokemon.all.order(experience: :asc)
    when "highest_price"
      Pokemon.all.order(experience: :desc)
    when "alphabetical_order"
      Pokemon.all.order(name: :asc)
    else
      Pokemon.all.order(name: :asc)
    end
  end

end
