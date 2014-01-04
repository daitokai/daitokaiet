json.array!(@records) do |record|
  json.extract! record, :id, :target_date, :weight, :comment, :created_at, :updated_at
  json.url post_url(record, format: :json)
end
