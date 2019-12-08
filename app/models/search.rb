class Search < ApplicationRecord
	belongs_to :member
	validates :query, presence: true, length: { minimum: 4 }
	validates :member_id, presence: true
end
