class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :target_user, class_name: 'User'

  validates :target_user, presence: true, uniqueness: {scope: [:user_id]}
end
