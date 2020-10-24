class Slot < ApplicationRecord
  has_one :appointment
  belongs_to :doctor
end