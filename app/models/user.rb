class User < ActiveRecord::Base
  include Wisper::Publisher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :records, dependent: :destroy
  has_many :follows, dependent: :destroy

  validates :goal, numericality: true, unless: Proc.new { |user| user.step == 0 }

  after_save :tweet_change_goal, if: Proc.new { |user| user.step > 0 }

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
        publish(:daitokaiet_goal_down, goal_was - goal)
      else
        publish(:daitokaiet_goal_up, goal - goal_was)
      end
    end
  end

  def update_first_step!
    if self.step == 0
      self.step = 1
      if self.save
        publish(:daitokaiet_start)
        return true
      end
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
end
