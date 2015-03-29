module CentersHelper

	def self.name_format(str)

		if str.length > 40 
			return str[0..40].gsub(/\s\w+\s*$/,'...')
		else
			return str
		end
	end

	def name_format(str)
		return CentersHelper.name_format(str)
	end

	def self.zipcode_format(str)
		if (str)
			zip = str.split("-")
			return zip[0]
		else
			str = "N/A"
			return str
		end
	end

	def zipcode_format(str)
		return CentersHelper.zipcode_format(str)
	end

	def self.title_format(str)
		str.sub(/\S/, &:upcase)
	end

	def title_format(str)
		return CentersHelper.title_format(str)
	end

	def self.link_format(str)
		if(str)
			if str[0..6] != "http://"
				"http://"+str
			else
				str
			end
		end
	end

	def link_format(str)
		return CentersHelper.link_format(str)
	end


end
