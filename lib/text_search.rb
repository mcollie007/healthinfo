class TextSearch

	def initialize(text, from_number, command, loc)
		@text = text
		@user_number = from_number
		@command = command
		@location = loc
		Rails.logger.debug(@command)
		Rails.logger.debug(@location)
		@service_number = "9545555454"
		@help_message = 'Service Commands:  CLINIC, MORE and HELP. Commands use: 
		CLINIC@zip_code, CLINIC@city_name, CLINIC@county_name, MORE returns remaining result, and HELP lists service commands.' 
	end

	def search
		
		case @command
		when 'CLINIC'
			
			Rails.logger.debug(@location)
		
			@search = Center.search do
				fulltext @location	
			end
			data = @search.results
			total = @search.total
			#Rails.logger.debug(data)
			Rails.logger.debug(total)
			@user = find_user
			if @user.update(data: data, total: total)
				amount = page_generator(total)
				#@search = text_page(data, total, amount)
			end
		when 'MORE'
			 #amount ||= @cmd[1] if empty
			@user = find_user
			if @user 
				data = @user.data
				total = @user.total
				amount = page_generator(total)
				#Rails.logger.debug(data)
				Rails.logger.debug(total)
				#@search = text_page(data, total, amount)
			end
		when 'HELP'
			#send help info to user
			
			@search = send(@help_message)
			#Rails.logger.debug(data)
			Rails.logger.debug(@search)
		else
			#send help info to user
			@search = send("Service Commands are: HELP, CLINIC, and MORE")
			Rails.logger.debug(@search)
		end

	end

	def text_page(data, total, amount)

		messages = data.shift(amount)

		messages.each do | msg |
			total-- 
			#if @user.update(total)  user.save
			message = message_generator(msg)
			return send(message)
			#if total > 0 send("#{total} results left. Type MORE or MORE@amount where amount = numbers 1-10")
			#end
			
		end
	end

	def send(message)
		#p = RestApi.new(Auth_id, Auth_Token)

		params = {
			'src' => @service_number,
			'dst' => @user_number,
			'text' => message,
			'type' => 'sms',
			'url' => 'http://webservice.com/status',
			'method' => 'POST'
		}

		#response = p.send_message(params)
		Rails.logger.debug(params)

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

	private

		def user_params
			params.require(:user).permit(:phone, :query, :data, :total)
		end

	protected 

		def message_generator(data)
			'Name: #{data.site_name}, Phone: #{data.phone_number}, Fax: #{data.fax_number}
				Mgmt: #{data.admin_number}; Address: #{data.address} #{data.city}, #{data.state}, 
				#{data.zip_code}, #{data.county_name}. This clinic is currently #{data.site_status} 
				and is at a #{data.location_type_desc} location. This is a #{data.op_schedule_desc} 
				#{data.center_type_desc} which is open #{data.op_calendar}'
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