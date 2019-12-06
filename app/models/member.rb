class Member < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships, dependent: :destroy
  validates :name, format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/, message: "only allows letters" }, uniqueness: true
  validates :heading, presence: true, length: { minimum: 12 }
  validates :website, format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: "is not a valid URL" }, uniqueness: true
end
