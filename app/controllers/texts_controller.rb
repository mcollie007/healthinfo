class TextsController < ApplicationController
	require 'text_search.rb'
	def receive
		from_number = params[:From] #from user
		to_number = params[:To] #this webservice
		text = params[:Text] #message recieved

		@user = User.find_by(phone: user_params[:phone])
		if @user
			User.update(query: user_params[text]) #= text => :user_query
		else 
			User.create(phone: user_params[from_number], query: user_params[text])# = text and from_number => :user_query, :user_number
			if @user.save?
				TextSearch.new(text, from_number).search
			end
		end
	end

	private
=begin
	def permit_all
		params.permit!
	end
=end
	def user_params
		params.require(:user).permit(:phone, :query)
	end
end
