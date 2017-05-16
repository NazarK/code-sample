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
        @slot = Slot.find(params[:card][:slot_id])
        ActiveRecord::Base.transaction do
          @card.card_type = @slot.card_type
          if @card.save
            @slot.card = @card
            if !@slot.save
              raise ActiveRecord::Rollback
            end
          end
        end
      end

      if params[:card][:list_id].present?
        list_id = params[:card][:list_id]
        list = List.find(list_id)
        @slot = list.slots.order(:id).where(card:nil)

        if @card.card_type.present?
          @slot.where!("card_type_id=? or card_type_id is null",@card.card_type_id)
        else
          @slot.where!(card_type:nil)
        end

        @slot = @slot.first
        if !@slot.present?
          @card.errors[:list]<<"no slots to accept the card left"
        else
          ActiveRecord::Base.transaction do
            if @card.save
              @slot.card = @card
              if !@slot.save
                raise ActiveRecord::Rollback
              end
            end
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
    ActiveRecord::Base.transaction do
      Slot.where(card:@card).first.update_attributes card_id: nil
      @card.destroy
    end
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
