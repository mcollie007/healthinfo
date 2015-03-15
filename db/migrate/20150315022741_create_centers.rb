class CreateCenters < ActiveRecord::Migration
  def change
    create_table :centers do |t|
      t.string :site_name
      t.string :phone_number
      t.string :fax_number
      t.string :admin_number
      t.string :website
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :pop_type_desc
      t.string :location_desc
      t.string :site_status
      t.string :location_type_desc
      t.string :center_type_desc
      t.string :op_schedule_desc
      t.string :op_calendar
      t.string :longitude
      t.string :latitude
      t.string :state_name
      t.string :county_name
      t.string :full_county_name

      t.timestamps null: false
    end
  end
end
