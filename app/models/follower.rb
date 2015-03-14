class Follower < ActiveRecord::Base
	  belongs_to :follower, :class_name => 'User', :foreign_key => 'follower_id'
  	  belongs_to :followed, :class_name => 'User', :foreign_key => 'followed_id'

  	  validates_presence_of :follower, :followed

  	  def notified!
  	  	self.notify = true
  	  	self.save
  	  end
end
