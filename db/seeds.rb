# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Stop words
stopwords = File.readlines("db/stopwords.txt").map(&:chomp)
stopwords.each do |word|
	Stopword.create(word: word, score: 1)
end