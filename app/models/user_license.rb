class UserLicense < ApplicationRecord
  belongs_to :user
  belongs_to :certification_center

  enum status: {
    cycling: 'cycling'
  }

  has_one_attached :pdf
end
