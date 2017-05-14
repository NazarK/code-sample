class MilestonesController < ApplicationController
  before_action :set_workflow
  before_action :set_milestone, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @milestones = Workflow.find(params[:workflow_id]).milestones.order(:id).all
    respond_with(@milestones)
  end

  def show
    respond_with(@milestone)
  end

  def new
    @milestone = Milestone.new
    respond_with(@milestone)
  end

  def edit
  end

  def create
    @milestone = Milestone.new(milestone_params)
    @milestone.workflow_id = params[:workflow_id]
    @milestone.save
    respond_with @milestone, location: (workflow_milestones_path if @milestone.errors.blank?)
  end

  def update
    @milestone.update(milestone_params)
    respond_with @milestone, location: (workflow_milestones_path if @milestone.errors.blank?)
  end

  def destroy
    @milestone.destroy
    respond_with(@milestone)
  end

  private
    def set_workflow
      @workflow = Workflow.find(params[:workflow_id])
    end

    def set_milestone
      @milestone = Milestone.find(params[:id])
    end

    def milestone_params
      params.require(:milestone).permit(:label, :color, :done)
    end
end
