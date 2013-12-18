class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :records, dependent: :destroy
  validates :goal, numericality: true

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create(name: auth.info.nickname,
                         provider: auth.provider,
                         uid: auth.uid,
                         token: auth.credentials.token,
                         secret: auth.credentials.secret,
                         email: User.create_unique_email,
                         password: Devise.friendly_token[0, 20]
      )
    else
      user.update_attributes(name: auth.info.nickname,
                             provider: auth.provider,
                             uid: auth.uid,
                             token: auth.credentials.token,
                             secret: auth.credentials.secret)
    end
    user
  end

  # 通常サインアップ時のuid用、Twitter OAuth認証時のemail用にuuidな文字列を生成
  def self.create_unique_string
    SecureRandom.uuid
  end

  # twitterではemailを取得できないので、適当に一意のemailを生成
  def self.create_unique_email
    User.create_unique_string + '@example.com'
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
