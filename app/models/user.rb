class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :records, dependent: :destroy
  has_many :follows, dependent: :destroy

  validates :goal, numericality: true, unless: Proc.new { |user| user.step == 0 }

  after_update :tweet_change_goal, if: Proc.new { |user| user.step > 0 }

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User
      .where(provider: auth.provider, uid: auth.uid)
      .first_or_initialize

    data = auth['info']
    attributes = {
      name: auth.info.nickname,
      token:  auth.credentials.token,
      secret: auth.credentials.secret,
      image_url: data['image'],
    }
    if user.new_record?
      attributes.merge!(email: User.create_unique_email,
                        password: Devise.friendly_token[0, 20],
                        goal: nil,

      )
    end
    user.update! attributes
    user
  end

  def follow_users
    self.follows.map(&:target_user)
  end

  def follow?(target_user)
    !self.follows.where(target_user_id: target_user.id).blank?
  end

  def follow(target_user)
    self.follows.create(target_user_id: target_user.id)
  end

  def unfollow(target_user)
    self.follows.find_by(target_user_id: target_user.id).destroy
  end

  def tweet_change_goal
    if goal_changed?
      if goal_was > goal
        tweet("目標体重をさらに#{goal_was - goal}kg減らしました！！ #daitokaiet")
      else
        tweet("目標体重を#{goal - goal_was}kg増やしちゃいました。。。 #daitokaiet")
      end
    end
  rescue
    logger.info('tweet失敗 at tweet_change_goal')
  end

  def update_first_step!
    if self.step == 0
      self.step = 1
      self.save!
      tweet('#daitokaiet をはじめました！')
      true
    end
  end

  def update_second_step!
    if self.step == 1
      self.step = 2
      self.save!
      true
    end
  end

  # 通常サインアップ時のuid用、Twitter OAuth認証時のemail用にuuidな文字列を生成
  def self.create_unique_string
    SecureRandom.uuid
  end

  # twitterではemailを取得できないので、適当に一意のemailを生成
  def self.create_unique_email
    User.create_unique_string + '@example.com'
  end

  def tweet(message)
    if ENV.key? 'NO_TWEET'
      logger.debug('[tweet]' + message)
    else
      twitter_client.update(message)
    end
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.oauth_token = self.token
      config.oauth_token_secret = self.secret
    end
  end
end
