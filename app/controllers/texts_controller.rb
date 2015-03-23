class TextsController < ApplicationController
	require 'text_search.rb'
	def receive
		@from_number = params[:From] #from user
		@to_number = params[:To] #this webservice
		@text = params[:Text] #message recieved

		@cmd = @text.split("@")#(/[\W@\s\>]/)
		@command = @cmd[0]
		@loc = @cmd[1]

		@user = User.find_by(phone: @from_number)
		if @user
			@user.update(query: @text) #= text => :user_query
			do_search
		else 
			
			@user = User.new(phone: @from_number, query: @text)# = text and from_number => :user_query, :user_number
			if @user.save
				do_search
			end
		end
	end

	private

	def permit_all
		params.permit!
	end

	def user_params
		params.require(:user).permit(:phone, :query)
	end

	protected

	def do_search
		@centers = TextSearch.new(@text, @from_number, @command, @loc).search
				if @centers
					respond_to do |format|
						format.json {render json: @centers} 
					end
				else
					@centers = []
					respond_to do |format|
						format.json {render json: @centers} 
					end
				end
	end

end
