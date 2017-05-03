class SlotsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_slot, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def switch
    @slot = Slot.find(params[:slot_id])
    @slot_other = Slot.find(params[:slot_other])
    slot_card_id = @slot.card_id
    slot_other_card_id = @slot_other.card_id

    Slot.transaction do
      @slot.update_attributes card_id: nil
      @slot_other.update_attributes card_id: nil

      @slot.update_attributes card_id: slot_other_card_id
      @slot_other.update_attributes card_id: slot_card_id

      if @slot.errors.present? || @slot_other.errors.present?
        raise ActiveRecord::Rollback
      end
    end

  end

  def index
    @slots = Slot.all
    respond_with(@slots)
  end

  def show
    respond_with(@slot)
  end

  def new
    @slot = Slot.new
    respond_with(@slot)
  end

  def edit
  end

  def create
    @slot = Slot.new(slot_params)
    @slot.save
    if !request.xhr?
      respond_with @slot, location: (slots_path if @slot.errors.blank?)
    end
  end

  def update
    @slot.update(slot_params)
    if !request.xhr?
      respond_with @slot, location: (slots_path if @slot.errors.blank?)
    end
  end

  def destroy
    @slot.destroy
    if !request.xhr?
      respond_with(@slot)
    end
  end

  private
    def set_slot
      @slot = Slot.find(params[:id])
    end

    def slot_params
      params.require(:slot).permit(:list_id, :card_id, :card_type_id)
    end
end
