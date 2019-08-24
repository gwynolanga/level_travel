class BuildingForm
  include ActiveModel::Model

  validates :name, :street, :building_number, :city, presence: true

  attr_accessor :name, :street, :building_number, :city

  def initialize(attributes = {})
    if attributes[:id].present?
      @building = Building.find(attributes[:id])

      self.name = attributes[:name]
      self.street = attributes[:street]
      self.building_number = attributes[:building_number]
      self.city = attributes[:city]
    else
      super
    end
  end

  def save
    if valid?
      create!
      true
    else
      false
    end
  end

  def update(attributes)
    attributes.each do |name, value|
      public_send("#{name}=", value)
    end

    if valid?
      update!
      true
    else
      false
    end
  end

  private

  def create!
    Building.create(name: name, address: concatenation_address_words)
  end

  def update!
    @building.update(name: name, address: concatenation_address_words)
  end

  def concatenation_address_words
    [street, building_number, city].compact.join(', ').strip
  end
end