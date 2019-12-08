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

  def self.search(term, id=nil)
    if term.blank?  # blank? covers both nil and empty string
      all
    else
      keywords = sanitize_search(term)
      return none if keywords.blank?

      puts "#################################"
      puts "# Running Search #{id} "
      puts "# q: #{term}"
      puts "# keywords: #{keywords}"
      puts "#################################}"
      
      # where('heading ILIKE ?', "%#{term}%")
      # where('heading ilike any (array[?])', keywords.map {|s| "%#{s}%"})
      where("members.tsv @@ to_tsquery(#{keywords})").order("ts_rank_cd(members.tsv, #{keywords}) DESC")

    end
  end

  def self.sanitize_search(query)
    # Break down term to phrases and strip of stop words  
    words = query.downcase.scan(/\w+/)
    keywords = words.select { |word| !$stop_words.include?(word) }.join(' & ') # format for Postgres tsquery
    sanitize keywords
  end
end
