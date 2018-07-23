require 'faker'

100.times do
  Restaurant.create(name: Faker::RockBand.name, address: Faker::Lovecraft.location)
end
