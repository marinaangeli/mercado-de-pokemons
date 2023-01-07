class DealsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_pokemon, only: %i[new create]
  before_action :set_satoshi_rate, only: %i[new create my_deals edit update]

  def index

  end

  def my_deals
    @my_sells = Deal.where(user: current_user).where.not(sell_date: nil)
    @my_holdings = Deal.where(user: current_user).where(sell_date: nil)
  end

  def new
    @deal = Deal.new
    # Get historical data
    set_historical_data
  end

  def create
    @deal = Deal.new
    @deal = Deal.new
    @deal.assign_attributes(pokemon: @pokemon, buy_date: Date.today, buy_price: @pokemon.experience*@satoshi_rate, user: current_user)
    if @deal.save
      redirect_to my_deals_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @deal = Deal.find(params[:id])
    @pokemon = @deal.pokemon
    set_historical_data
  end

  def update
    @deal = Deal.find(params[:id])
    @pokemon = @deal.pokemon
    @deal.update(sell_date: Date.today, sell_price: @pokemon.experience*@satoshi_rate)
    redirect_to my_deals_path
  end

  private

  def set_historical_data
    rates = HTTParty.get("https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=BRL&limit=60&api_key=#{ENV.fetch('API_KEY', nil)}").parsed_response['Data']
    values = rates.map do |r|
      {
        date: Time.at(r['time']).to_date,
        close: r['close']
      }
    end
    @data = values.map do |h|
      [
        h[:date],
        h[:close] * @pokemon.experience.to_i * 0.00000001
      ]
    end
  end

  # Set the satoshi rate from a third-party API
  def set_satoshi_rate
    response = HTTParty.get("https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=BRL&api_key=#{ENV.fetch('API_KEY', nil)}")
    @satoshi_rate = response["BRL"].to_d*0.00000001
  end

  # Set the pokemon based on the pokemon_id parameter
  def set_pokemon
    @pokemon = Pokemon.find(params[:pokemon_id])
  end

  def deal_params
    params.require(:deal).permit(:buy_date, :buy_price, :sell_date, :sell_price, :user_id, :pokemon_id)
  end
end
