# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Pokemon.destroy_all

response = HTTParty.get('https://pokeapi.co/api/v2/pokemon?limit=1500')
results = response['results']
# @pokemons = []
results.each do |result|
  url = result["url"]
  r = HTTParty.get(url)
  Pokemon.create!(
    name: result["name"].capitalize,
    image_url: r["sprites"]["front_default"],
    experience: r["base_experience"].to_d
  )
end

@pokemons = Pokemon.all

@pokemons.each do |pokemon|
  puts "#{pokemon.name} - #{pokemon.image_url} - #{pokemon.experience}"
end
