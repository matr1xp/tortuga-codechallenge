class Member < ApplicationRecord
  attr_accessor :search_score, :friend_connection
  has_many :searches
  has_many :friendships
  has_many :friends, through: :friendships, dependent: :destroy
  validates :name, format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/, message: "only allows letters" }, uniqueness: true
  validates :heading, presence: true, length: { minimum: 15 }
  validates :website, format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: "is not a valid URL" }, uniqueness: true

  def self.exclude(id)
    where.not(id: id)
  end

  def self.search(pattern, id=nil)
    if pattern.blank?  # blank? covers both nil and empty string
      all
    else
      # Break down pattern to phrases	
      # 1. Filter out "stop words"
      
      words = pattern.downcase.scan(/\w+/)
      keywords = words.select { |word| !$stop_words.include?(word) }

      puts "#################################"
      puts "# Running Search #{id} "
      puts "# q: #{pattern}"
      puts "# keywords: #{keywords.join(' ')}"
      puts "#################################}"
      
      # where('heading ILIKE ?', "%#{pattern}%")
      where('heading ilike any (array[?])', keywords.map {|s| "%#{s}%"})      
    end
  end
end
