# spec/factories/members.rb
FactoryBot.define do
	factory :member do
		trait :member1 do
			name { "Member One" }
		 	heading { "Member 1 short heading" }
		 	website { "http://google.com/1" }
		end
		trait :member1_alias do
			name { "Member One" }
		 	heading { "Member 1 short heading" }
		 	website { "http://google.com/1_1" }
		end
		trait :member2 do
		 	name { "Member Two" }
		 	heading { "Member 2 short heading" }
		 	website { "http://google.com/2" }
		end
		trait :member2_alias do
			name { "Member Two Alias" }
		 	heading { "Member 2 short heading" }
		 	website { "http://google.com/2" }
		end
		trait :member3 do
			name { "Member Three" }
		 	heading { "Member 3 short heading" }
		 	website { "http://google.com/3" }
		end
	end
end

