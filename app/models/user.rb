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

end
