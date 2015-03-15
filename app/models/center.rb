class Center < ActiveRecord::Base

=begin
	site_name phone_number fax_number admin_number website address city state zip_code pop_type_desc
          location_desc site_status location_type_desc center_type_desc op_schedule_desc op_calendar longitude latitude
          state_name county_name full_county_name
=end
	searchable do 
		text :zip_code #, :as => :zip_code_textp
		text :county_name, :full_county_name
		
	end
end
#searc using solr, locate centers by location using county_name, full_county_name, and zip_code