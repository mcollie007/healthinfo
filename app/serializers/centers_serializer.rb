class CentersSerializer < ActiveModel::Serializer
  attributes :id, :total, :page, :per_page, :first_page?, :last_page?, :centers
	#attribute :length, key: :returned_count

	def centers
		object.results.map {|c| CentersSerializer.new(c)}
	end
end
