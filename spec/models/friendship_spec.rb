require 'rails_helper'

RSpec.describe Friendship, :type => :model do
	subject { 
		described_class.new(member_id: 1, friend_id: 1)
	}
	describe "Validations" do
		it { should validate_presence_of(:member) }
		it "is valid with valid attributes" do
		#	expect(subject).to be_valid
		end
	end
	describe "Associations" do
		it { should belong_to(:member) }
		it { should belong_to(:friend) }
	end
end