class CentersController < ApplicationController

	def index

		if params[:search].present?
			#Rails.logger.debug(:search)
			@search = Center.search do
				
				fulltext params[:search]
				paginate :page => params[:page] || 1, :per_page => 5
			end
			
			@centers = @search.results
			
		else
			@centers = []
			
		end

	end

	private

	def permit_all
		params.permit!
	end
end
