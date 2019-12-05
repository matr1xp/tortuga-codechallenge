class Friend < ApplicationRecord
  belongs_to :member, polymorphic: true
end
