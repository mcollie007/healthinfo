class CenterSerializer < ActiveModel::Serializer
  attributes :id, :zip_code, :county_name, :full_county_name, :city

  url :center
end
