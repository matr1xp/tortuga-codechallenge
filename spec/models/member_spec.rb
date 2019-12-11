require 'rails_helper'

RSpec.describe Member, :type => :model do

	describe "Validations" do
		subject { 
			described_class.new(id: 1, name: "My Name", heading: "My short heading", website: "http://www.google.com")
		}
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

	describe "create!" do
		it "is valid if names are unique" do
			member1 = create(:member, :member1)
			expect(member1.name).to eql "Member One"
			member2 = create(:member, :member2)
			expect(member2.name).to eql "Member Two"
			member3 = create(:member, :member3)
			expect(member3.name).to eql "Member Three"
		end
		it "is not valid if name already exists" do
			member1 = create(:member, :member1)
			member1_alias = build(:member, :member1_alias)
			expect(member1).to be_valid
			expect(member1_alias).to_not be_valid
		end
		it "is not valid if website is already taken" do
			member2 = create(:member, :member2)
			member2_alias = build(:member, :member2_alias)
			expect(member2).to be_valid
			expect(member2_alias).to_not be_valid
		end
	end
	
	describe "exclude!" do
		it "is not valid if :member1 is included" do
			member1 = create(:member, :member1)
			member2 = create(:member, :member2)
			member3 = create(:member, :member3)
			expect(member1).to be_valid
			members = Member.all.exclude(member1.id)
			expect(members).to_not include(member1)
		end
	end

	describe "search!" do
		it "is valid if all members are returned" do
			member1 = create(:member, :member1)
			member2 = create(:member, :member2)
			search = Member.search("")
			expect(search).to include(member1, member2)
		end
		it "is valid only if `Member 1` is returned" do
			member1 = create(:member, :member1)
			member2 = create(:member, :member2)
			search = Member.search("Member 1")
			expect(search).to include(member1)
			expect(search).to_not include(member2)
		end
		it "is valid if all members are returned" do
			member1 = create(:member, :member1)
			member2 = create(:member, :member2)
			member3 = create(:member, :member3)
			search = Member.search("Members")
			expect(search).to include(member1, member2, member3)
		end
	end

	describe "sanitize_search!" do
		it "is valid if `member & 1` is returned" do
			member1 = create(:member, :member1)
			sanitize_search = Member.sanitize_search("<!-- Member 1 />")
			expect(sanitize_search).to eql "'member & 1'"
		end
		it "is valid if stop_word `the` is not included" do
			member1 = create(:member, :member1)
			sanitize_search = Member.sanitize_search("<!-- The Member />")
			expect(sanitize_search).to eql "'member'"
		end
	end

end