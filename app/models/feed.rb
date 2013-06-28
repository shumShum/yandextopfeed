class Feed < ActiveRecord::Base
  attr_accessible :title, :body, :url

  validates :title, presence: true
  validates :body, presence: true
  validates :url, presence: true
  
end
