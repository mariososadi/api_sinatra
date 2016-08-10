class User < ActiveRecord::Base
  has_many :tweets

  validates :handle, :presence => true
  validates :handle, :uniqueness => true

end
