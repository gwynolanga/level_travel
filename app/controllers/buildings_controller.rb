class BuildingsController < ApplicationController
  before_action :find_building, only: %i[edit update destroy]

  def index
    respond_to do |format|
      format.html do
        @building_form = BuildingForm.new
        @buildings = Building.all
        gon.random_building = @buildings.sample
        gon.buildings = @buildings
        gon.addresses = @buildings.map(&:address)
        gon.root_url = root_path
      end

      format.js do
        @buildings = Building.near([params[:latitude], params[:longitude]], 4, order: :distance)
      end
    end
  end

  def create
    @building_form = BuildingForm.new(building_form_params)
    respond_to do |format|
      if @building_form.save
        format.html { redirect_to(root_path, flash: { success: 'Building was created' }) }
      else
        flash.now[:error] = 'Invalid fields for creating building'
        format.js { render(:create) }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @building_form.update(building_form_params)
        format.html { redirect_to(root_path, flash: { success: 'Building was updated' }) }
      else
        flash.now[:error] = 'Invalid fields for updating building'
        format.js { render(:edit) }
      end
    end
  end

  def destroy
    @building.destroy
    redirect_to(root_path, flash: { success: 'Building was destroyed' })
  end

  private

  def find_building
    @building = Building.find(params[:id])
    address_words = @building.address.split(', ')
    attributes = {
      id: params[:id],
      name: @building.name,
      street: address_words.first,
      building_number: address_words.second,
      city: address_words.third
    }

    @building_form = BuildingForm.new(attributes)
  end

  def building_form_params
    params.require(:building_form).permit(:name, :street, :building_number, :city)
  end
end
