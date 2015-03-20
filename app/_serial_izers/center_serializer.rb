class CenterSerializer < ActiveModel::Serializer
	attributes :zip_code, :county_name, :full_county_name, :city
end