class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update(cleaned_params)
    redirect_to @project
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(cleaned_params)
    @project.save
    redirect_to @project
  end

private
  def cleaned_params
    params.require(:project).permit(:name, :description, :website, :target_pledge_amount, :pledging_ends_on)
  end
end
