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
	
	describe "create_inverse!" do
		it "is valid if other friend record is created" do
			member1 = create(:member, :member1)
			member2 = create(:member, :member2)
			Friendship.create(member_id: member1.id, friend_id: member2.id)
			friendship = Friendship.find_by_member_id(member2.id)
			expect(friendship).to be_valid
			expect(friendship.friend_id).to eq(member1.id) 
		end
	end

	describe "destroy_inverses!" do
		it "is valid if all friends are destroyed" do
			member1 = create(:member, :member1)
			member2 = create(:member, :member2)
			friendship = Friendship.create(member_id: member1.id, friend_id: member2.id)
			Friendship.destroy(friendship.id)
			friendships = Friendship.all
			expect(friendships).to be_empty
		end
	end

	describe "has_inverse?" do
		it "is valid if other friend exists" do
			member1 = create(:member, :member1)
			member2 = create(:member, :member2)
			friendship = Friendship.create(member_id: member1.id, friend_id: member2.id)
			has_inverse = friendship.has_inverse?
			expect(has_inverse).to eq(true)
		end
	end

	describe "inverses!" do
		it "is valid if other friend record is returned" do
			member1 = create(:member, :member1)
			member2 = create(:member, :member2)
			friendship = Friendship.create(member_id: member1.id, friend_id: member2.id)
			inverse = friendship.inverses
			expect(inverse).to_not be_empty
			expect(inverse.first.member_id).to eql(friendship.friend_id) 
		end
	end

	describe "inverse_friend_options!" do
		it "is valid if friend_id is swapped to member_id" do

		end
	end
end