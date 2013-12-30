json.users do
  json.array!(current_user.follow_users) do |user|
    json.extract! user, :id, :name, :created_at
    json.record_count user.records.size
    json.url api_v1_show_social_url(name: user.name, format: :json)
  end
end
