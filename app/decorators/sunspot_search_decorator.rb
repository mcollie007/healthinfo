class SunspotSearchDecorator < Draper::Decorator
	include ActiveModel::SerializerSupport
	delegate_all
	delegate :total, to :object
	delegate :page, :per_page, to: 'object.query'
	delegate :length, :first_page?, :last_page?, to: 'object.results'
end