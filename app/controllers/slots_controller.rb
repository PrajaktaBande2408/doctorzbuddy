class SlotsController < ApplicationController
  before_action :set_slot, only: [:show, :edit, :update, :destroy, :book]
  before_action :verify_doctor_authorization!, except: [:index, :book]

  def index
    @slots = if current_doctor.present?
      current_doctor.slots
    elsif current_patient.present?
      Slot.where(booked: false)
    end
  end

  def show
  end

  def new
    @slot = current_doctor.slots.new
  end

  def edit
  end

  def create
    @slot = current_doctor.slots.build(slot_params)
    respond_to do |format|
      if @slot.save
        format.html { redirect_to @slot, notice: 'Slot was successfully created.' }
        format.json { render :show, status: :created, location: @slot }
      else
        format.html { render :new }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @slot.update(slot_params)
        format.html { redirect_to @slot, notice: 'Slot was successfully updated.' }
        format.json { render :show, status: :ok, location: @slot }
      else
        format.html { render :edit }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @slot.destroy
    respond_to do |format|
      format.html { redirect_to slots_url, notice: 'Slot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def book
    @appointment = @slot.build_appointment(patient_id: current_patient.id)
    if @appointment.save
      respond_to do |format|
        format.html { redirect_to @appointment, notice: 'Appointment has been booked successfully.' }
        format.json { render :show, status: :ok, location: @appointment }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_slot
    @slot = if current_doctor.present?
      current_doctor.slots.find(params[:id])
    else
      Slot.find(params[:id])
    end
  end

  def slot_params
    params.fetch(:slot, {}).permit(:from_time, :to_time, :date)
  end

  def verify_doctor_authorization!
    if current_doctor.blank?
      respond_to do |format|
        format.html { redirect_to roots_url, notice: 'Unathorized Access.' }
        format.json { render json: {message: 'Unathorized Access.'}, status: :unprocessable_entity }
        # format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end
end
