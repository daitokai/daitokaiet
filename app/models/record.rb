class Record < ActiveRecord::Base
  belongs_to :user

  validates :target_date, presence: true, uniqueness: {scope: [:user_id]}

  def to_goal
    self.weight.to_f - self.user.goal.to_f
  end
end
