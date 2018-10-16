class UserMailer < ApplicationMailer
	def send_mail(ge,msg)
		@msg1=msg
		mail(to: ge, from: "restaurant.book123@gmail.com", subject: "Reservation Confirmation", message: @msg1)
	end
end
