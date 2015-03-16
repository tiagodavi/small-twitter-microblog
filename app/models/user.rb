class User < ActiveRecord::Base

	validates_presence_of :name
	validates :login, presence: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9_]+\Z/ }
	validates :email, presence: true, uniqueness: true, format: {with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
 	
	has_secure_password
	has_attached_file :avatar, :styles => { :medium => '300x300>', :thumb => '100x100>' }, :default_url => '/images/:style/missing.png'
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	
	def self.authenticate(login, password)
		user = find_by(login: login).try(:authenticate, password)	
	end

	def tweet!(content)
		if content.present?
			Tweet.create({user:self,content:content})
		end		
	end

	def total(symbol='')
		method = "total_#{symbol}"
		self.respond_to?(method) ? self.send(method) : 0
	end

	def total_tweets
		Tweet.where(user: self).count
	end

	def total_following
		Follower.where(follower: self).count
	end

	def total_followers
		Follower.where(followed: self).count
	end

	def new_followers
		Follower.where(followed: self, notify: false)
	end

	def eql?(other_user)		
		login == other_user.login
	end

	def follow!(other_user)
		unless self.following?(other_user)
			Follower.create({follower: self, followed: other_user, notify:false}) 
		end
	end

	def unfollow!(other_user)
		if self.following?(other_user)		
			Follower.where(follower:self, followed:other_user).delete_all		
		end		
	end

	def following?(other_user)
		follower = Follower.where(follower: self, followed: other_user).first		
		follower.present?		
	end

end
