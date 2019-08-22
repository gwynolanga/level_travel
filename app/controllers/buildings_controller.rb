class BuildingsController < ApplicationController
  def index
    @buildings = Building.all
  end

  def new
    @building = Building.build
  end

  def create
    @building = Building.build(building_params)
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def building_params
    params.require(:building).permit(:name, :address, :latitude, :longitude)
  end
end