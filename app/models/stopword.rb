class Stopword < ApplicationRecord
	validates :word, presence: true, uniqueness: true
end
