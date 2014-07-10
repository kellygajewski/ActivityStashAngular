class SpotsController < ApplicationController
	before_action :authenticate_user 
	before_action :get_activity, only: [:show, :edit, :update, :destroy]
	
	def index
		@activities = current_user.activities
	end

	def show
		@cs = Geocoder.coordinates(@activity.location)
		@lat = @cs[0]
		@lng = @cs[1]
	end

end
