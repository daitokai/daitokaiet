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
    previous_or_next(:previous)
  end

  def next_record
    previous_or_next(:next)
  end

  def previous_or_next(type)
    date = self.target_date
    records = self.user.records
    if type == :previous
      records = records.where { target_date < date }.order(target_date: :desc)
    else
      records = records.where { target_date > date }.order(target_date: :asc)
    end
    records.first
  end

  def calc_supplement_weight
    if prev_data = self.previous
      if next_data = self.next_record
        weight_delta = next_data.weight.to_f - prev_data.weight.to_f
        date_delta = next_data.target_date - prev_data.target_date
        self.weight = prev_data.weight.to_f + ((weight_delta.to_f / date_delta) * (self.target_date - prev_data.target_date))
        self
      end
    end
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
