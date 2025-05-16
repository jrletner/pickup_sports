class Location < ApplicationRecord
  # validations

  # associations
  belongs_to :locationable, polymorphic: true
end
