class Record < ActiveRecord::Base
  belongs_to :user

  validates :target_date, presence: true, uniqueness: {scope: [:user_id]}
  validates :comment, length: {maximum: 100}

  after_save :update_twitter

  def to_goal
    self.weight.to_f - self.user.goal.to_f
  end

  def delta
    if prev = self.previous
      self.weight.to_f - prev.weight.to_f
    end
  end

  def previous
    date = self.target_date
    self.user
      .records
      .where{ target_date < date }
      .order(target_date: :desc)
      .first
  end

  def update_twitter
    self.user.twitter_client.update recorded_tweet
  rescue
    logger.info('tweet失敗 at update_twitter')
  end

  def recorded_tweet
    value = self.to_goal.round(2)
    comment = "#{self.comment} " if self.comment.present?
    footer = "#daitokaiet #{comment}| #{self.target_date}"
    "目標体重まであと#{value}kg #{footer}"
  end
end
