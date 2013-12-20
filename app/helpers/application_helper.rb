module ApplicationHelper
  def user_icon(user)
    render 'user_icon', user: user
  end
end
