class Tweet < ActiveRecord::Base
  scope :most_recent, -> { order('created_at DESC') }

  belongs_to :user

  validates_presence_of :user, :content  
end
