class ActivitiesController < ApplicationController

	before_action :authenticate_user 
	before_action :get_activity, only: [:show, :edit, :update, :destroy]

	# skip_before_filter :verify_authenticity_token
	# before_filter :cors_preflight_check
	# after_filter :cors_set_access_control_headers

	# # For all responses in this controller, return the CORS access control headers.
	# def cors_set_access_control_headers
	# 	headers['Access-Control-Allow-Origin'] = '*'
	# 	headers['Access-Control-Allow-Methods'] = 'PATCH, DELETE, POST, GET, OPTIONS'
	# 	headers['Access-Control-Max-Age'] = "1728000"
	# end

	# # If this is a preflight OPTIONS request, then short-circuit the
	# # request, return only the necessary headers and return an empty
	# # text/plain.
	# def cors_preflight_check
	# 	headers['Access-Control-Allow-Origin'] = '*'
	# 	headers['Access-Control-Allow-Methods'] = 'PATCH, DELETE, POST, GET, OPTIONS'
	# 	headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Content-Type'
	# 	headers['Access-Control-Max-Age'] = '1728000'
	# end

	respond_to :json, :html
	
	def index
		@activities = current_user.activities
		respond_with @activities
		# @cs = Geocoder.coordinates(@activity.location)
		# @lat = @cs[0]
		# @lng = @cs[1]
	end

	def show
		@cs = Geocoder.coordinates(@activity.location)
		@lat = @cs[0]
		@lng = @cs[1]
		respond_with @activity
	end

	def new
		@activity = Activity.new
		@category = Category.all
	end

	def create
		@activity = current_user.activities.new(activity_params)
    	respond_to do |format|
	      	if @activity.save 
	       	  format.html { redirect_to activities_path }
	          format.json { render action: 'index', status: :created, location: @activity }
	      	else
	         format.html { render action: 'new' }
	         format.json { render json: @activity.errors, status: :unprocessable_entity }
	        end
    	end
	end

	def edit
		@categories = Category.all
	end

	def update
		respond_to do |format|
		if @activity.update_attributes(activity_params)
			format.html { redirect_to activity_path }
			format.json { head :no_content }
		else
			format.html { render action: 'edit' }
        	format.json { render json: @activity.errors, status: :unprocessable_entity }
      	end
	end
	end

	def destroy
		@activity.destroy
		respond_to do |format|
			format.html { redirect_to activities_path }
			format.json { head :no_content }
		end
	end

  private

    def get_activity
		@activity = Activity.find(params[:id])
	end

	def activity_params
		params.require(:activity).permit(:name, :location, :link, :notes, :category_ids => [])
	end

end
