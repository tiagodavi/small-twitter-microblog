class Tweet < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user, :content
  
  def creator
  	user.name
  end
end
