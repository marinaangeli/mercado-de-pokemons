class DealsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_pokemon, only: %i[new create]
  before_action :set_satoshi_rate, only: %i[new create]

  def index

  end

  def my_deals
    @my_deals = Deal.where(user: current_user)
    set_satoshi_rate
  end


  def new
    @pokemon = Pokemon.find(params[:pokemon_id])
    @deal = Deal.new
  end

  def create
    @deal = Deal.new
    @deal.pokemon = @pokemon
    @deal.buy_date = Date.today
    @deal.buy_price = @pokemon.experience*@satoshi_rate
    @deal.user = current_user
    if @deal.save
      redirect_to my_deals_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

  end

  def update

  end

  private

  def set_satoshi_rate
    api_key = '181edf265ab80e07441e75e6111435f4347ebf5703a1ca0d8ec4b53efb437e94'
    response = HTTParty.get("https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=BRL&api_key=#{api_key}")
    @satoshi_rate = response["BRL"].to_d*0.00000001
  end

  def set_pokemon
    @pokemon = Pokemon.find(params[:pokemon_id])
  end

end
