json.array!(@lists) do |list|
  json.extract! list, :id, :name, :is_private
  json.url list_url(list, format: :json)
end
