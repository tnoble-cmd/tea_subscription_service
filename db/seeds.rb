# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Tea.destroy_all

# Create seed data for teas
teas = [
  { title: 'Green Tea', description: 'A soothing green tea.', temperature: 80, brew_time: 2 },
  { title: 'Black Tea', description: 'A strong black tea.', temperature: 100, brew_time: 3 },
  { title: 'Herbal Tea', description: 'A calming herbal tea.', temperature: 90, brew_time: 5 },
  { title: 'Oolong Tea', description: 'A traditional oolong tea.', temperature: 85, brew_time: 4 },
  { title: 'White Tea', description: 'A delicate white tea.', temperature: 75, brew_time: 2 }
]

# Create teas in the database
teas.each do |tea|
  Tea.create!(tea)
end

puts "Seeded #{Tea.count} teas."