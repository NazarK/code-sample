class SlotsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_slot, only: [:show, :edit, :update, :destroy]

  respond_to :html

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
