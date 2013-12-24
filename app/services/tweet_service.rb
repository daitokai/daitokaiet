class TweetService
  include Rails.application.routes.url_helpers

  def initialize(user)
    @user = user
  end

  def daitokaiet_start
    tweet '#daitokaiet をはじめました！'
  end

  def daitokaiet_recorded(record)
    value = record.to_goal.round(2)
    comment = "#{record.comment} " if record.comment.present?
    url = show_social_url(@user.name)

    footer = "#daitokaiet #{comment}| #{record.target_date} #{url}"
    tweet "目標体重まであと#{value}kg #{footer}"
  end

  def daitokaiet_goal_down(weight)
    tweet "目標体重をさらに#{weight}kg減らしました！！ #daitokaiet"
  end

  def daitokaiet_goal_up(weight)
    tweet "目標体重を#{weight}kg増やしちゃいました。。。 #daitokaiet"
  end

  private

    def tweet(message)
      if ENV.key? 'NO_TWEET'
        Rails.logger.debug('[tweet]' + message)
      else
        twitter_client.update(message)
      end
    end

    def tweet_client
      Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_KEY']
        config.consumer_secret = ENV['TWITTER_SECRET']
        config.oauth_token = @user.token
        config.oauth_token_secret = @user.secret
      end
    end

    def default_url_options(options = {})
      { host: 'daitokaiet.herokuapp.com' }.merge(options)
    end
end
