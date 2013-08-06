class BookingsController < ApplicationController

  before_filter :require_user, :only => [:new, :create, :destroy, :edit, :update, :search]
  before_filter :getBooking, :only => [:edit, :update, :destroy]

    def index
        @bookings = current_user.bookings.paginate(page: params[:page])
    end

    def new
      @booking = Booking.new
      @property = Property.find(params[:property_id])
    end

    def create
      @property = Property.find(params[:booking][:property_id])
      params[:booking][:user_id] = current_user.id
      @booking = @property.bookings.build(params[:booking])
      
      if @booking.save
        flash[:success] = "Property booked!!"
        redirect_to bookings_path
      else
        render 'new'
      end
    end

    def edit
    end

    def update
        @booking.book_from = params[:booking][:book_from]
        @booking.book_till = params[:booking][:book_till]

        if @booking.update_attributes(params[:booking])
            flash[:notice] = "Booking updated!"
            redirect_to bookings_path
        else
            render :action => 'edit'
        end
    end

    def destroy
        @booking.destroy
        redirect_to bookings_path
    end

    def search
        @property = Property.find(params[:id])
        @bookings = @property.bookings
    end

    def getBooking
      @booking = Booking.find(params[:id])
    end 

end