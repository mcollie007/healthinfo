class TextSearch
	

	def initialize(text, from_number, command, loc)
		@text = text
		@user_number = from_number
		@command = command
		@location = loc
		
		@service_number = "+15619485417"
		@help_message = 'Service Commands:  CLINIC and HELP. Commands use: 
		CLINIC@zip_code, CLINIC@city_name, CLINIC@county_name and HELP lists service commands.' 
	end

	def search
		
		case @command
		when 'CLINIC'
			
			
			@search = Center.search do
				fulltext search_params
				#paginate :page => params[:page] || 1, :per_page => 5
			end
			
			data = @search.results
			
			total = @search.total
			
			@user = find_user
			if @user.update(data: data, total: total)
				
				@search = text_page( data, total, 3)
			end
		when 'MORE'
			 
			@user = find_user
			if @user 
				data = @user.data
				
				total = @user.total
				
				@search = text_page( data, total, 3)
			end
		when 'HELP'
			#send help info to user
			
			@search = send(@help_message)
			
		else
			#send help info to user
			@search = send("Service Commands are: HELP and CLINIC")
			
		end

	end

	def search_params
		
		params = @location
	
	end

	def text_page(data, total, amount)

		
		#@user = find_user
		for i in 0..amount
		    message = message_generator(data[i])
			sendTwilio(message)
		end
		
=begin
			data.each do |msg|
				message = message_generator(msg)
			##Rails.logger.debug(message)
				send(message)
			end
=end
	end

	
	def sendTwilo(msge)
	    @client = Twilio::REST::Client.new ENV['PRO_SID'], ENV['PRO_TOKEN']
 
        message = @client.account.messages.create(:body => msge,
            :to => @user_number,     # Replace with your phone number
            :from => @service_number)   # Replace with your Twilio number
        puts message.sid
	end

	def send(message)
		#p = RestApi.new(ENV['AUTH_ID'], ENV['AUTH_TOKEN'])

		params = {
			'src' => @service_number,
			'dst' => @user_number,
			'text' => message,
			'type' => 'sms',
			'url' => 'http://webservice.com/status',
			'method' => 'POST'
		}

		#response = p.send_message(params)
		#Rails.logger.debug(params)

		#uuid = response[1]['message_uuid'][0]

		#params1 = {
		#	'record_id' => uuid
		#}

		return params
		#response = p.get_message(params1) #save to log db

	end

	def find_user
		User.find_by(phone: @user_number) 
	end

	def find_data(id)
		Center.find(id)
	end

	private

		def user_params
			params.require(:user).permit(:phone, :query, :data, :total)
		end

	protected 

		def message_generator(data)
			"Name: #{data.site_name}, Phone: #{data.phone_number}, Fax: #{data.fax_number} Mgmt: #{data.admin_number}; Address: #{data.address} #{data.city}, #{data.state}, #{data.zip_code}, #{data.county_name}. This clinic is currently #{data.site_status} and is at a #{data.location_type_desc} location. This is a #{data.op_schedule_desc} #{data.center_type_desc} which is open #{data.op_calendar}"
		end

		def page_generator(total)
			if total %4 == 0
				total / 4 
			
			elsif total %3 == 0
				total / 3

			else 
				total / 2
			end
		end

end