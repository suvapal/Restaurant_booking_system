class ReservationsController < ApplicationController
	def index
		@reservations = Restaurant.find(params[:id])
	end
	def show
		@resshow = Restaurant.find(params[:id])
		flash[:notice] = ""
            flash[:success] = ""
	end
	def create
		ge = params[:reservation][:gemail]
		gid = RGuest.select('id').where("email=?", ge)
		gg=gid.ids
		@resshow = Restaurant.find(params[:id])
		max_count=@resshow.max
		min_count=@resshow.min
		table=@resshow.table
		g_count=params[:reservation] [:gc].to_i
		dt = Date.parse(params[:reservation] [:reservationdate]).strftime("%Y-%m-%d")
		hour=Time.parse(params[:reservation] [:reservationtime]).strftime("%H").to_i
		time=Time.parse(params[:reservation] [:reservationtime]).strftime("%H:%M:%S")
		ms=Time.parse(params[:reservation] [:reservationtime]).strftime("%M:%S")
		hour1=hour+1
            hour2=hour-1
            time2=hour2.to_s+":"+ms
		time1=hour1.to_s+":"+ms
		dttime="2000-01-01 "+ time
		dttime1="2000-01-01 "+ time1
            dttime2="2000-01-01 "+ time2
		 if gg[0].nil?
		 	 flash[:notice] = "Guest Email does not exsist! Please register first."
		 	else
		 		if g_count > max_count
      			flash[:notice] = "Too many guests"
                        flash[:success] =""
    			else if g_count < min_count
      			flash[:notice] = "Too few guests"
                        flash[:success] =""
      			else
      				if 9 < hour && hour < 13  
      					count = Reservation.where(:shift => "DAY").where(:date =>dt).where(:resid => @resshow.id).where("time > ? or time = ? AND time < ? or time = ?",dttime,dttime,dttime1,dttime1).count
                                    countp = Reservation.where(:shift => "DAY").where(:date =>dt).where(:resid => @resshow.id).where("time > ? AND time < ?",dttime2,dttime).count
      					if count < table && countp < table
      						res = Reservation.new(:resid => @resshow.id, :gid => gg[0], :gcount => g_count, :bookingstat => "Y", :date => dt, :time => time, :shift => "DAY")
      						if(res.save)
      						flash[:success] = "Reservation is Booked!"
                                          flash[:notice] =""
      						msg="Your Booking has been confirmed at "+time+" on "+dt+". Restaurant :"+ @resshow.name
      						UserMailer.send_mail(ge,msg).deliver
      						@gname=RGuest.all.where("email=?", ge)
      						msg1="There is a table Booking at"+time+" on "+dt+". Guest :"+ @gname[0].name
      						UserMailer.send_mail(@resshow.email,msg1).deliver
      						else
      							flash[:notice] = "Reservation failed!"
                                                flash[:success] =""
      					      end
      					else
      						flash[:notice] = "All the tables are occupied. Reservation can not be done. Please try some other time"
      					       flash[:success] =""
      					end
      				
      				else if 18 < hour && hour < 23
                                    countp = Reservation.where(:shift => "EVE").where(:date =>dt).where(:resid => @resshow.id).where("time > ? AND time < ?",dttime2,dttime).count
      					count = Reservation.where(:shift => "EVE").where(:date =>dt).where(:resid => @resshow.id).where("time > ? or time = ? AND time < ? or time = ?",dttime,dttime,dttime1,dttime1).count
      					if count < table && countp < table
      						res = Reservation.new(:resid => @resshow.id, :gid => gg[0], :gcount => g_count, :bookingstat => "Y", :date => dt, :time => time, :shift => "EVE")
      						if(res.save)
      						flash[:success] = "Reservation is Booked!"
                                          flash[:notice] =""
      						msg="Your Booking has been confirmed at "+time+" on "+dt+". Restaurant :"+ @resshow.name
      						UserMailer.send_mail(ge,msg).deliver
      						@gname=RGuest.all.where("email=?", ge)
      						msg1="There is a table Booking at"+time+" on "+dt+". Guest :"+ @gname[0].name
      						UserMailer.send_mail(@resshow.email,msg1).deliver
      						else
      							flash[:notice] = "Reservation failed!"
                                                flash[:success] =""
      						end
      					else
      						flash[:notice] = "All the tables are occupied. Reservation can not be done. Please try some other time"
      					       flash[:success] =""
      					end
      				else
      					flash[:notice] = "Restaurant is closed! Try between 9AM to 1PM and 6PM to 11PM"
      				        flash[:success] =""
                              end
                              end
    			      end
                        end
    			end
      render 'show'
	end	
end
