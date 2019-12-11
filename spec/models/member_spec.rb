require 'rails_helper'

RSpec.describe Member, :type => :model do
	subject { 
		described_class.new(id: 1, name: "My Name", heading: "My short heading", website: "http://www.google.com")
	}
	describe "Validations" do
		it "is valid with valid attributes" do
			expect(subject).to be_valid
		end
		it "is not valid without a name" do
			subject.name = nil
			expect(subject).to_not be_valid
		end
		it "is not valid without a heading" do
			subject.heading = nil
			expect(subject).to_not be_valid
		end
		it "is not valid without a website" do
			subject.website = nil
			expect(subject).to_not be_valid
		end
		it "is not valid if name has invalid characters" do
			subject.name = "123 abc"
			expect(subject).to_not be_valid
		end
		it "is not valid if heading is too short" do
			subject.heading = "My heading"
			expect(subject).to_not be_valid
		end
		it "is not valid if website is not properly formatted" do
			subject.website = "me@google.com"
			expect(subject).to_not be_valid
		end
	end
	describe "Associations" do
		it { should have_many(:friends)	}
		it { should have_many(:friendships) }
		it { should have_many(:searches) }
	end
end