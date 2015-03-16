require 'rails_helper'

RSpec.describe User, type: :model do

  describe ".authenticate" do
  	it "Not is possible to authenticate with not existent user" do
  		user = User.authenticate('user','user')

  		expect(user).to be_nil
  	end
  	it "Is possible to authenticate a user with valid login and password" do
  		login, password = "user", "user"  		
  		created_user = User.create({name:'user',email:'user@test.com',login:login, password:password})

  		authenticated_user = User.authenticate(login,password)

  		expect(authenticated_user.id).to eq(created_user.id)
  	end
  end

  describe "#tweet!" do
  	it "Is possible to create a tweet to a user" do
  		first_user  = User.create({name:'First User',email:'first_user@test.com',login:'first_user', password:'123'})
  		first_tweet = "First Tweet"
  		
  		first_user.tweet!(first_tweet)
  		tweet = Tweet.last

  		expect(tweet.content).to eq(first_tweet)
  	end
  end

  describe "#total" do
  	it "The total is zero when method does not exists" do
  		user = User.new

  		total = user.total(:something)

  		expect(total).to eq(0)
  	end
  	it "The total is zero when method exists, but don't have value" do
  		user = User.new

  		total = user.total(:tweets)

  		expect(total).to eq(0)
  	end
  	it "The total is greater than zero when have value" do
  		first_user  = User.create({name:'First User',email:'first_user@test.com',login:'first_user', password:'123'})
  		
  		first_user.tweet!("First Tweet")
  		total = first_user.total(:tweets)

  		expect(total).to be > 0
  	end
  end

  describe "#following?" do
  	it "Is possible know if a user is follower of the another" do
  		first_user  = User.create({name:'First User',email:'first_user@test.com',login:'first_user', password:'123'})
  		second_user = User.create({name:'Second User',email:'second_user@test.com',login:'second_user', password:'123'})

  		first_user.follow!(second_user)  		
  		result = first_user.following?(second_user)

  		expect(result).to be_truthy  		
  	end
  	it "Following is false to invalid users" do
  		first_user  = User.create({name:'First User',email:'first_user@test.com',login:'first_user', password:'123'})
  		  	
  		result = first_user.following?(:something)

  		expect(result).to be_falsey
  	end
  end

  describe "#follow!" do
  	it "A user can follow another" do
		first_user  = User.create({name:'First User',email:'first_user@test.com',login:'first_user', password:'123'})
  		second_user = User.create({name:'Second User',email:'second_user@test.com',login:'second_user', password:'123'})

  		first_user.follow!(second_user)
  		follower = Follower.last

  		expect([follower.follower.login, follower.followed.login]).to match_array([first_user.login, second_user.login])
  	end
  end

  describe "unfollow!" do
  	it "A user can to stop follow another" do
  		first_user  = User.create({name:'First User',email:'first_user@test.com',login:'first_user', password:'123'})
  		second_user = User.create({name:'Second User',email:'second_user@test.com',login:'second_user', password:'123'})

  		first_user.follow!(second_user)
  		first_user.unfollow!(second_user)
		result = first_user.following?(second_user)

		expect(result).to be_falsey
  	end
  end

  describe "#new_followers" do
  	it "Is possible to know the news followers of the user" do
  		first_user  = User.create({name:'First User',email:'first_user@test.com',login:'first_user', password:'123'})
  		second_user = User.create({name:'Second User',email:'second_user@test.com',login:'second_user', password:'123'})
  		
  		first_user.follow!(second_user)
  		result = second_user.new_followers.first

		expect(result.follower.login).to eq(first_user.login)
  	end
  end
end
