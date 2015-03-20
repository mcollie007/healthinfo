class CentersController < ApplicationController
	respond_to :json
	def index

		if params[:search].present?
			#Rails.logger.debug(:search)
			@search = Center.search do
				
				fulltext params[:search]
				paginate :page => params[:page] || 1, :per_page => 5
			end
			
			@centers = @search.results
			@total = @search.total
			respond_to do |format|
				format.html 
				format.json {render json: @centers} #{render :index, status: :created, location: @centers}#
			end
			
		else
			@centers = []
			@total = 0
			respond_to do |format|
				format.html {render :index}
				format.json {render json: @centers}
			end
		end

	end

	def show
		@center = Center.find(params[:id])
		
		respond_to do |format|
			format.html {render :show}
			format.json {render :show, status: :created, location: @center}
		end
	end

	private

	def permit_all
		params.permit!
	end
end
