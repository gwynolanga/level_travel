class BuildingsController < ApplicationController
  before_action :find_building, only: %i[edit update destroy]

  def index
    @building = Building.new
    @buildings = Building.all
  end

  def create
    @building = Building.new(building_params)
    respond_to do |format|
      if @building.save
        format.html { redirect_to(root_path, notice: 'Building was created') }
      else
        format.js { render(:create) }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @building.update(building_params)
        format.html { redirect_to(root_path, notice: 'Building was updated') }
      else
        format.js { render(:edit) }
      end
    end
  end

  def destroy
    @building.destroy
    redirect_to(root_path, notice: 'Building was destroyed')
  end

  private

  def find_building
    @building = Building.find(params[:id])
  end

  def building_params
    params.require(:building).permit(:name, :street, :house_number, :city, :latitude, :longitude)
  end
end
