class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    tweet_bag = Twitter.user_timeline(username)
    tweet_bag.each do |tweet|
      self.tweets << Tweet.find_or_create_by_text(text: tweet[:text])
    end
    self.save!
  end
end
