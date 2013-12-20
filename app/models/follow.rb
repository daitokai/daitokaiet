class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :target_user, class_name: 'User'
end
