class ActivitiesController < ApplicationController

	before_action :authenticate_user 
	before_action :get_activity, only: [:show, :edit, :update, :destroy]

	def get_activity
		@activity = Activity.find(params[:id])
	end

	def index
		@activities = Activity.all
	end

	def show
	end

	def new
		@activity = Activity.new
	end

	def create
		@activity = Activity.new(params.require(:activity).permit(:name, :location, :link, :notes))
		if @activity.save
			redirect_to activities_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @activity.update_attributes(params.require(:activity).permit(:name, :location, :link, :notes))
			redirect_to activity_path
		else
			render 'edit'
		end
	end

	def destroy
		@activity.destroy
		redirect_to activities_path
	end

end
