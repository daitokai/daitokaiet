json.user do
  json.extract! @user, :id, :name, :created_at
  json.record_count @user.records.size
  json.url api_v1_show_social_url(name: @user.name, format: :json)
  json.records do
    json.array!(@user.records.where(target_date: Date.today - 30.days..Date.today).order(target_date: :desc)) do |record|
      json.extract! record, :target_date, :comment
      json.to_goal record.to_goal.round(2)
    end
  end
end
