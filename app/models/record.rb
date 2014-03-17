class Record < ActiveRecord::Base
  include Wisper::Publisher

  belongs_to :user

  validates :target_date, presence: true, uniqueness: {scope: [:user_id]}
  validates :weight, presence: true, numericality: {greater_than: 0}
  validates :comment, length: {maximum: 100}

  after_create { publish(:daitokaiet_recorded, self) }

  def self.liner_interpolate(start_x, start_y, end_x, end_y, x)
    delta_x = end_x - start_x
    delta_y = end_y - start_y
    start_y + (delta_y.to_f / delta_x) * (x - start_x)
  end

  def to_goal
    self.weight.to_f - self.user.goal.to_f
  end

  def delta
    if prev = self.previous_record
      self.weight.to_f - prev.weight.to_f
    end
  end

  def previous_record
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

  def calc_interpolate_weight
    if prev_data = self.previous_record and next_data = self.next_record
      self.weight = Record.liner_interpolate(
        prev_data.target_date, prev_data.weight,
        next_data.target_date, next_data.weight,
        self.target_date
      )
      self
    end
  end
end
