require 'rails_helper'

RSpec.describe UserSession, type: :model do
	describe "#authenticate!" do
		it "Not authenticate invalid user" do
			user_session = UserSession.new({},{})

			result = user_session.authenticate!

			expect(result).to be_falsey
		end
		it "Authenticate valid user" do
			login, password = "user", "user"  
			created_user = User.create({name:'user',email:'user@test.com',login:login, password:password})
			user_session = UserSession.new({},{login: login, password: password})

			result = user_session.authenticate!

			expect(result).to be_truthy
		end
	end

	describe "#register" do
		it "Is possible to register a user" do
			created_user = User.create({name:'user',email:'user@test.com',login:'login', password:'password'})
			user_session = UserSession.new({},{})

			user_id = user_session.register(created_user)

			expect(user_id).to eq(created_user.id)
		end
	end

	describe "#current_user" do
		it "Is possible get current user after of authenticate" do
			login, password = "user", "user"  
			created_user = User.create({name:'user',email:'user@test.com',login:login, password:password})
			user_session = UserSession.new({},{login: login, password: password})

			user_session.authenticate!
			current_user = user_session.current_user

			expect(current_user).to eq(created_user)
		end
	end

	describe "#user_signed_in?" do
		it "Is possible verify is user is authenticated" do
			login, password = "user", "user"  
			created_user = User.create({name:'user',email:'user@test.com',login:login, password:password})
			user_session = UserSession.new({},{login: login, password: password})

			user_session.authenticate!

			expect(user_session.user_signed_in?).to be_truthy
		end
	end

	describe "#destroy" do
		it "Is possible to exit the Microblog" do
			login, password = "user", "user"  
			created_user = User.create({name:'user',email:'user@test.com',login:login, password:password})
			user_session = UserSession.new({},{login: login, password: password})

			user_session.authenticate!
			user_session.destroy
			
			expect(user_session.user_signed_in?).to be_falsey
		end
	end
end