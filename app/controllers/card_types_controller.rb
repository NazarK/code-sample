class CardTypesController < ApplicationController
  before_action :set_card_type, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @card_types = CardType.order(:id).all
    respond_with(@card_types)
  end

  def show
    respond_with(@card_type)
  end

  def new
    @card_type = CardType.new
    respond_with(@card_type)
  end

  def edit
  end

  def create
    @card_type = CardType.new(card_type_params)
    @card_type.save
    respond_with @card_type, location: (card_types_path if @card_type.errors.blank?)
  end

  def update
    @card_type.update(card_type_params)
    respond_with @card_type, location: (card_types_path if @card_type.errors.blank?)
  end

  def destroy
    @card_type.destroy
    respond_with(@card_type)
  end

  private
    def set_card_type
      @card_type = CardType.find(params[:id])
    end

    def card_type_params
      params.require(:card_type).permit(:name, :workflow_id)
    end
end
