json.array!(@centers) do |center|
  json.extract! center, :id, :site_name, :address, :city, :state, :zip_code, :site_status, :longitude, :latitude, 	:state_name, :county_name, :full_county_name
  json.url center_url(center, format: :json)
end