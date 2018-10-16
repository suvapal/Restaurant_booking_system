class GuestsController < ApplicationController
	def index
		@guests = RGuest.all
	end
	def new
		@guest= RGuest.new
	end
	def destroy
		@guest = RGuest.find(params[:id])
		@guest.destroy
		redirect_to guests_path
	end
	def show	
			@guest = RGuest.find(params[:id])
		
	end

	def create
		#render plain: params[:post].inspect
		@guest = RGuest.new(guest_params)
		if (@guest.save)
		render 'show'
	else
		render 'new'
	end
	end

	def edit
		@guest = RGuest.find(params[:id])
	end
	def update
		@guest = RGuest.find(params[:id])
		if (@guest.update(guest_params))
		render 'show'
	else
		render 'edit'
	end
	end


	private def guest_params
		params.require(:guest).permit(:name, :phone, :email)
	end
end
