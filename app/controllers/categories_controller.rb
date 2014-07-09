class CategoriesController < ApplicationController
	before_action :authenticate_user 
	before_action :get_category, only: [:show, :edit, :update, :destroy]
	
	def index
		@categories = current_user.categories
	end

	def show
		@activities = current_user.activities
	end

	def new
		@category = Category.new
	end

	def create
		@category = current_user.categories.new(params.require(:category).permit(:name))
	      	if @category.save 
	       	  redirect_to categories_path
	      	else
	         render 'new'
	        end
	end

	def edit
	end

	def update
		if @category.update_attributes(params.require(:category).permit(:name))
			redirect_to categories_path
		else
			render 'edit'
      	end
	end

	def destroy
		@category.destroy
		redirect_to categories_path 
	end

  private

    def get_category
		@category = Category.find(params[:id])
	end

end
