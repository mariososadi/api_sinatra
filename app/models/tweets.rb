class Tweets < ActiveRecord::Base
  belongs_to :user

  validates :tweet, :presence => true

  def self.updated?(handle, id)
    @first = CLIENT.user_timeline(handle, options = {:count => 2}).second.full_text.to_s
    @tweet = self.where(user_id: id).second.tweet.to_s

    return @first == @tweet
  end

end
