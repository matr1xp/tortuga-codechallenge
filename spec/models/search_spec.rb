require 'rails_helper'

RSpec.describe Search, :type => :model do
	describe "Validations" do
		it "is valid with valid attributes" do
			member = create(:member, :member1)
			search = Search.create(query: "Member heading", member_id: member.id)
			expect(search).to be_valid
		end
		it "is not valid if query length is less than 4 characters" do
			member = create(:member, :member2)
			search = Search.create(query: "123", member_id: member.id)
			expect(search).to_not be_valid
		end
		it "is not valid if there is no member_id" do
			search = Search.create(query: "Something interesting")
			expect(search).to_not be_valid
		end
		it "is not valid if member does not exist" do
			search = Search.create(query: "Something interesting", member_id: 999)
			expect(search).to_not be_valid
		end
	end
	describe "Associations" do
		it { should belong_to(:member) }
	end
end