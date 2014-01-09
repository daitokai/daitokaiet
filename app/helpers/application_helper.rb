module ApplicationHelper
  def user_icon(user)
    render 'user_icon', user: user
  end

  def show_weight(weight)
    number_with_precision weight, precision: 2
  end
end
