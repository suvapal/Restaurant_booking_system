class PostsController < ApplicationController
	def index
		@posts = Restaurant.all
	end
	def new
		@post= Restaurant.new
	end
	def showeditdelete
	end
	def show
		if $x==1
			$x=0
			@post = Restaurant.find(params[:id])
		else
			redirect_to(:controller => 'reservations', :action => 'show', :id => params[:id])
		end
	end

	def create
		@post = Restaurant.new(post_params)
		if (@post.save)
			$x=1
		render 'show'
	else
		render 'new'
	end
	end
	private def post_params
		params.require(:post).permit(:name, :phone, :email, :table, :max, :min)
	end
end
