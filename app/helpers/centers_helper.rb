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
		zip = str.split("-")
		return zip[0]
	end

	def zipcode_format(str)
		return CentersHelper.zipcode_format(str)
	end


end
