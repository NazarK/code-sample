class WorkflowsController < ApplicationController
  before_action :set_workflow, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @workflows = Workflow.all
    respond_with(@workflows)
  end

  def show
    respond_with(@workflow)
  end

  def new
    @workflow = Workflow.new
    respond_with(@workflow)
  end

  def edit
  end

  def create
    @workflow = Workflow.new(workflow_params)
    @workflow.save
    respond_with @workflow, location: (workflows_path if @workflow.errors.blank?)
  end

  def update
    @workflow.update(workflow_params)
    respond_with @workflow, location: (workflows_path if @workflow.errors.blank?)
  end

  def destroy
    @workflow.destroy
    respond_with(@workflow)
  end

  private
    def set_workflow
      @workflow = Workflow.find(params[:id])
    end

    def workflow_params
      params.require(:workflow).permit(:name)
    end
end
