# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Pokemon.destroy_all
Deal.destroy_all
User.destroy_all

response = HTTParty.get('https://pokeapi.co/api/v2/pokemon?limit=1500')
results = response['results']
results.each do |result|
  url = result["url"]
  r = HTTParty.get(url)
  Pokemon.create!(
    name: result["name"].capitalize,
    image_url: r["sprites"]["front_default"],
    experience: r["base_experience"].to_d
  )
end
pokemon = Pokemon.all.sample

user = User.create!(
  email: "teste@teste",
  password: "aaaaaa"
)

10.times do
  buy_date = Date.today - rand(0..60)
  date_range = (Date.today - buy_date).to_i
  days = rand(0..date_range)
  sell_date = buy_date + days

  Deal.create!(
    buy_date: buy_date,
    buy_price: rand(0.1..0.3),
    sell_date: sell_date,
    sell_price: rand(0.1..0.3),
    user: user,
    pokemon: pokemon
  )
end

15.times do
  buy_date = Date.today - rand(0..60)

  Deal.create!(
    buy_date: buy_date,
    buy_price: rand(0.1..0.3),
    user: user,
    pokemon: pokemon
  )
end
