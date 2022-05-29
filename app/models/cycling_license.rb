class CyclingLicense < ApplicationRecord
  belongs_to :user
  belongs_to :certification_center
end
