class ListsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_list, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def switch
    list = List.find(params[:list_id])
    list_other = List.find(params[:list_other])
    List.transaction do
      save = list.position
      list.update_attributes position: list_other.position
      list_other.update_attributes position: save
    end
  end

  def reorder
    params[:new_order].each_with_index do |list_id,i|
      List.find(list_id).update_attributes position: i
    end
  end

  def index
    @lists = List.all
    respond_with(@lists)
  end

  def show
    respond_with(@list)
  end

  def new
    @list = List.new
    respond_with(@list)
  end

  def edit
  end

  def create
    @list = List.new(list_params)
    @list.save
    if !request.xhr?
      respond_with @list, location: (lists_path if @list.errors.blank?)
    end
  end

  def update
    @list.update(list_params)
    if !request.xhr?
      respond_with @list, location: (lists_path if @list.errors.blank?)
    end
  end

  def destroy
    @list.destroy
    if !request.xhr?
      respond_with(@list)
    end
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:id, :name)
    end
end
