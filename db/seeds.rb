# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

duos = CSV.read("musician_author_seed.csv", headers: false)

duos.each do |row|
  duo = {}
  duo[:musician] = row[0]
  duo[:author] = row[1]
  duo[:news_source] = row[2]
  duo[:persisted_dictionary] = row[3]

  SuggestedPairing.create(duo)
end
