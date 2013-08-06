class PropertiesController < ApplicationController
    
    before_filter :require_user, :only => [:new, :create, :destroy, :edit, :update]
    before_filter :getProperty, :only => [:edit, :update, :destroy]
    
    def index
      @properties = current_user.properties.paginate(page: params[:page])
    end

    def new
      @property = Property.new
    end

    def create
      @property = current_user.properties.build(params[:property])
      @property.city = @property.city.downcase

      if @property.save
        flash[:success] = "Property details are posted!!"
        redirect_to properties_path
      else
        flash[:error] = "Details could not be posted, try again!"
        render 'new'
      end
    end
    
    def edit
    end

    def update
      if @property.update_attributes(params[:property])
        flash[:success] = "Details updated!"
        redirect_to properties_path
      else
        flash[:notice] = "Details could not be updated, try again!"
        redirect_to properties_path
      end
    end

    def destroy
      @property.destroy
      redirect_to properties_path
    end
    
    def search
      @properties = Property.with_city(params[:city]).with_start(params[:start]).with_end(params[:end])
    end

    def getProperty
      @property = current_user.properties.find(params[:id])
    end
end