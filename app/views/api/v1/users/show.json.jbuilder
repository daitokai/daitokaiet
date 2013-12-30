json.user do
  json.extract! current_user, :id, :name, :goal, :created_at, :updated_at
end
