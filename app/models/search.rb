class Search < ApplicationRecord
	belongs_to :member
	validates_presence_of :query
	validates :query, length: { minimum: 4 }, if: "query.present?"
	validates_presence_of :member_id
end
