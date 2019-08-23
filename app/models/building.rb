class Building < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.street_changed? || obj.house_number_changed? || obj.city_changed? }

  validates :name, :street, :house_number, :city, presence: true

  def address
    [street, house_number, city].compact.join(', ').strip
  end
end
