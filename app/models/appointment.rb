class Appointment < ApplicationRecord

  belongs_to :slot
  belongs_to :patient
  has_one :doctor, through: :slot

  after_commit :book_slot, on: :create
  after_commit :unbooked_slot, on: :destroy

  def book_slot
    slot.update(booked: true)
  end

  def unbooked_slot
    slot.update(booked: false)
  end
end