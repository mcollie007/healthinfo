class TextsController < ApplicationController
	require 'text_search.rb'
	def receive
		from_number = params[:From] #from user
		to_number = params[:To] #this webservice
		text = params[:Text] #message recieved

		# @user = User.find_by(:phone)
		# if @user? we update User.update(user_params) = text => :user_query
		#|else User.new(user_params) = text and from_number => :user_query, :user_number
		# if @user.save?
		#TextSearch.new(text, from_number).search
		#end
	end

	private

	def permit_all
		params.permit!
	end
end
