class SlotsController < ApplicationController
  before_action :set_slot, only: [:show, :edit, :update, :destroy]
  before_action :verify_doctor_authorization!

  def index
    @slots = current_doctor.slots
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

  private

  def set_slot
    @slot = current_doctor.slots.find(params[:id])
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
