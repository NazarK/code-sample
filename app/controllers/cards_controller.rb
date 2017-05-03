class CardsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @cards = Card.all
    respond_with(@cards)
  end

  def show
    respond_with(@card)
  end

  def new
    @card = Card.new
    respond_with(@card)
  end

  def edit
  end

  def create
    @card = Card.new(card_params)
    if request.xhr?

      if params[:card][:slot_id].present?
        slot = Slot.find(params[:card][:slot_id])
        if @card.save
          slot.update_attribute :card, @card
        end
      end

      if params[:card][:list_id].present?
        list_id = params[:card][:list_id]
        list = List.find(list_id)
        slot = list.slots.order(:id).where(card:nil).first
        if !slot.present?
          @card.errors[:list]<<"no empty slots left"
        else
          if @card.save
            slot.update_attribute :card, @card
          end
        end
      end

    else
      @card.save
      respond_with @card, location: cards_path if @card.errors.blank?
    end

  end

  def update
    @card.update(card_params)
    if !request.xhr?
      respond_with @card, location: (cards_path if @card.errors.blank?)
    end
  end

  def destroy
    @card.destroy
    respond_with(@card)
  end

  private
    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:id, :name, :text, :list_id, :card_type_id)
    end
end
