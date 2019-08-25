class BuildingsController < ApplicationController
  def index
    @buildings = Building.all

    respond_to do |format|
      format.html(&method(:gon_variables))
      format.js { @buildings = Building.near([params[:latitude], params[:longitude]], 4, order: :distance) }
    end
  end

  private

  def gon_variables
    gon.random_building = @buildings.sample
    gon.buildings = @buildings
    gon.addresses = @buildings.map(&:address)
    gon.root_url = root_path
  end
end
