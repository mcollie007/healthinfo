require 'csv'
require 'active_record'
require 'activerecord-import'

namespace :csv do
  task :import_hcc => :environment do
    
    fields_to_insert = %w{ site_name phone_number fax_number admin_number website address city state zip_code pop_type_desc
          location_desc site_status location_type_desc center_type_desc op_schedule_desc op_calendar longitude latitude
          state_name county_name full_county_name}
    rows_to_insert = []

    CSV.foreach("#{Rails.root}/lib/data/hcc_mod.csv", headers: true) do |row|
      row_to_insert = row.to_hash.select { |k, v| fields_to_insert.include?(k) }
      #rows_to_insert << row_to_insert
      Center.create!(row_to_insert)
      #Center.import(rows_to_insert)
    end
    
  end
end 
#rake csv:import_hcc